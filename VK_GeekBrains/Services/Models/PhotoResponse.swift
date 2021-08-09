//
//  PhotoResponse.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 09.08.2021.
//

import Foundation

// MARK: - UserPhotosFromAPI
struct UserPhotos: Codable {
    let response: PhotoResponse
}

// MARK: - Response
struct PhotoResponse: Codable {
    let count: Int
    let items: [PhotoItem]
}

// MARK: - Item
struct PhotoItem: Codable {
    let albumID: Int
    let reposts: Reposts
    let postID: Int?
    let id, date: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let likes: Likes
    
    var height: Int {
        return getProperSize().height
    }
    var width: Int {
        return getProperSize().width
    }
    var srcBIG: String {
        return getProperSize().url
    }
    
    private func getProperSize() -> Size {
        if let sizeX = sizes.first(where: { $0.type.rawValue == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return Size(width: 0, height: 0, url: "wrong image", type: TypeEnum.z)
        }
    }

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case reposts
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case likes
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
