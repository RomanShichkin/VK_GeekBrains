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
    
    
    func getUser() {
        guard let token = authService.token else { return }
        guard let userId = authService.userId else { return }
        let path = "users.get"
        
        let parameters: Parameters = [
            "user_ids": userId,
            "fields": "bdate,counters",
            "access_token": token,
            "v": version
        ]
        let url = baseUrl + path
        
        AF.request(url,
                   method: .get,
                   parameters: parameters
        ).responseData { response in
            guard let data = response.value else { return }
            print(data.prettyJSON as Any)
        }
    }
    
    func getFeed(nextBatchFrom: String?, completion: @escaping (FeedResponse?) -> Void) {
        guard let token = authService.token else { return }
        let path = "newsfeed.get"
        let parameters: Parameters = [
            "access_token": token,
            "filters": "post,photo",
            "start_from": nextBatchFrom as Any,
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
            }
        }
    }
    
    func getFriendsList(completion: @escaping ([FriendsItem]) -> Void) {
        guard let token = authService.token else { return }
        let path = "friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "order": "hints",
            "fields": "bdate,domain,photo_100",
            "count": "10",
            "v": version
        ]
        
        let url = baseUrl + path
        
        DispatchQueue.main.async {
            AF.request(url,
                       method: .get,
                       parameters: parameters
            ).responseData { response in
                guard let data = response.value else { return }
                //                print(data.prettyJSON as Any)
                let usersList = try! JSONDecoder().decode(FriendsList.self, from: data).response.items
                print(usersList as Any)
                completion(usersList)
            }
        }
    }
    
    
    
    func getFriends(completion: @escaping ([FriendsItem]?) -> Void) {
        guard let token = authService.token else { return }
        let path = "friends.get"
        let parameters: Parameters = [
            "access_token": token,
            "order": "hints",
            "fields": "bdate,domain,photo_100",
            "count": "10",
            "v": version
        ]
        
        let url = baseUrl + path
        DispatchQueue.main.async {
            AF.request(url,
                       method: .get,
                       parameters: parameters
            ).responseData { response in
                guard let data = response.value else { return }
                
                let decodableResponse = self.networkDataFetcher.decodeJSON(type: FriendsList.self, from: data)
                completion(decodableResponse?.response.items)
                
            }
        }
        
    }
    
    func getGroups(completion: @escaping ([GroupItem]) -> Void) {
        guard let token = authService.token else { return }
        let path = "groups.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "extended": "1",
            "count": "50",
            "v": version
        ]
        let url = baseUrl + path
        
        DispatchQueue.main.async {
            AF.request(url,
                       method: .get,
                       parameters: parameters
            ).responseData { response in
                guard let data = response.value else { return }
                
                let userGroups = try! JSONDecoder().decode(GroupsList.self, from: data).response.items
                completion(userGroups)
            }
        }
    }
    
    func getUserPhotos(userId: String, completion: @escaping ([PhotoItem]) -> Void) {
        guard let token = authService.token else { return }
        let path = "photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": userId,
            "access_token": token,
            "extended": "1",
//            "count": "3",
            "v": version
        ]
        
        let url = baseUrl + path
        
        AF.request(url,
                   method: .get,
                   parameters: parameters
        ).responseData { response in
            guard let data = response.value else { return }
            let userPhotos = try! JSONDecoder().decode(UserPhotos.self, from: data).response.items
            print(userPhotos as Any)
            completion(userPhotos)
        }
    }
    
}
