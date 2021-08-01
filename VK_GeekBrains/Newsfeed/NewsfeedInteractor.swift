//
//  NewsfeedInteractor.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 31.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
    private let networkService = NetworkService()
    var feedresponse = FeedResponse(items: [FeedItem](), profiles: [Profile](), groups: [Group]())
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    
    case .getNewsFeed:
        networkService.getFeed() {[weak self] feedresponse in
            guard let feedresponse = feedresponse else { return }
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feedresponse))
            self?.feedresponse = feedresponse
//            print(self?.feedresponse as Any)
        }
    }
    
  }
  
}
