//
//  NetworkService.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 28.07.2021.
//

import Foundation
import Alamofire

final class NetworkService {
    private let authService: AuthService
    private let networkDataFetcher = NetworkDataFetcher()
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    private let baseUrl = "https://api.vk.com/method/"
    private let version = "5.131"
    private let queue = OperationQueue()
    
    func getFeed(completion: @escaping (FeedResponse?) -> Void) {
        guard let token = authService.token else { return }
        let path = "newsfeed.get"
        let parameters: Parameters = [
            "access_token": token,
            "filters": "post,photo",
//            "count": "1",
            "v": version
        ]
        
        let url = baseUrl + path
        DispatchQueue.main.async {
            AF.request(url,
                       method: .get,
                       parameters: parameters
            ).responseData { response in
                guard let data = response.data else { return }
                let decodableResponse = self.networkDataFetcher.decodeJSON(type: FeedResponseWrapped.self, from: data)
                completion(decodableResponse?.response)
//                print(decodableResponse as Any)
            }
        }
    }
}
