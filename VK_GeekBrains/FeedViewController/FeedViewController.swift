//
//  FeedViewController.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 28.07.2021.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    var feedResponse = FeedResponse(items: [FeedItem](), profiles: [Profile](), groups: [Group]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        networkService.getFeed() {[weak self] feedResponse in
            guard let feedResponse = feedResponse else { return }
            self?.feedResponse = feedResponse
            print(self?.feedResponse as Any)
        }
    }
}
