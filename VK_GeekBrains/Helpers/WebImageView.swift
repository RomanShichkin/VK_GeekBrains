//
//  WebImageView.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 31.07.2021.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}

class PhotoService {
    
    private static let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    private static let cacheImagesURL: URL? = {
        let path = "Images"
        
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let imagesFolderURL = cacheDirectory.appendingPathComponent(path, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: imagesFolderURL.path) {
            try? FileManager.default.createDirectory(at: imagesFolderURL, withIntermediateDirectories: true, attributes: [:])
        }
        
        return imagesFolderURL
    }()
    
    private var memoryImageCache: [String: UIImage] = [:]
    
    // MARK: - Private Methods
    
    private func getFilePath(at url: URL) -> String? {
        let hashName = url.lastPathComponent
        return Self.cacheImagesURL?.appendingPathComponent(hashName).path
    }
    
    private func saveImageToCache(_ image: UIImage, with url: URL) {
        guard let filePath = self.getFilePath(at: url) else { return }
        let imageData = image.pngData()
        FileManager.default.createFile(atPath: filePath, contents: imageData)
    }
    
    private func getImageFromCache(at url: URL) -> UIImage? {
        guard let filePath = self.getFilePath(at: url) else { return nil }
        
        guard let modificationDate = try? FileManager.default.attributesOfItem(atPath: filePath)[.modificationDate] as? Date else {
            return nil
        }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= Self.cacheLifeTime,
              let image = UIImage(contentsOfFile: filePath) else {
            return nil
        }
        
        DispatchQueue.main.async {
            self.memoryImageCache[filePath] = image
        }
        
        return image
    }
}

extension PhotoService {
    
    static let shared = PhotoService()
    
    func loadImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                guard let filePath = self.getFilePath(at: url) else { return }
                self.memoryImageCache[filePath] = image
            }
            
            self.saveImageToCache(image, with: url)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()

    }
    
    func getPhoto(at url: URL, completion: @escaping (UIImage?) -> Void) {
        assert(Thread.isMainThread, "Must call on main thread")
        
        if let filePath = self.getFilePath(at: url),
           let image = self.memoryImageCache[filePath] {
            return completion(image)
        } else if let image = self.getImageFromCache(at: url) {
            return completion(image)
        } else {
            self.loadImage(at: url, completion: completion)
        }
    }
}

extension UIImageView {
    func setImage(at url: URL) {
        PhotoService.shared.getPhoto(at: url) { [weak self] image in
            self?.image = image
        }
    }
}
