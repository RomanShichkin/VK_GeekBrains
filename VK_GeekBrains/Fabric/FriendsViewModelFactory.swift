//
//  FriendsViewModelFactory.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 18.08.2021.
//

import Foundation
import UIKit

class FriendsViewModelFactory {
    func constructViewModel(from friendList: [FriendsItem]) -> [FriendsViewModel] {
        return friendList.compactMap { getViewModel(from: $0) }
    }
    
    private func getViewModel(from friend: FriendsItem) -> FriendsViewModel {
        let nameLabel = friend.firstName + " " + friend.lastName
        let descriptionLabel: String
        friend.bdate != nil ? (descriptionLabel =  "ДР: " + friend.bdate!) : (descriptionLabel = "Дата рождения не указана")
        let mainImage = imageFromUrl(from: friend.photo100)
        
        return FriendsViewModel(mainImage: mainImage,
                                nameLabel: nameLabel,
                                descriptionLabel: descriptionLabel)
    }
    
    private func imageFromUrl(from photo100: String) -> UIImage? {
        let mainImage = UIImageView()
        guard let url = URL(string: photo100) else { return nil }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let _ = UIImage(data: data) {
                DispatchQueue.main.async {
                    mainImage.setImage(at: url)
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
        return mainImage.image
    }
    
}
