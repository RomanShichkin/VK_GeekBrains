//
//  VkAdapter.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 18.08.2021.
//

import Foundation

class VkAdapter {
    private let networkService = NetworkService()
    var friendsList = [FriendsItem]()
    
    func adapterGetFriends(then completion: @escaping ([FriendsItem]) -> Void){
        networkService.getFriendsList() {[weak self] list in
//            guard let friendsList = friendsList else { return }
            self?.friendsList = list
//            print(self?.friendsList as Any)
        }
    }
}
