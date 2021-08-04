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
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    case .getNewsFeed:
        service?.getFeed(completion: { [weak self] (revealedPostIds, feed) in
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealdedPostIds: revealedPostIds))
        })
    case .revealPostIds(postId: let postId):
        service?.revealPostIds(forPostId: postId, completion: { [weak self]  (revealedPostIds, feed) in
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealdedPostIds: revealedPostIds))
        })
    case .getNextBatch:
        service?.getNextBatch(completion: { [weak self] (revealedPostIds, feed) in
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealdedPostIds: revealedPostIds))
        })
    }
  }
}
