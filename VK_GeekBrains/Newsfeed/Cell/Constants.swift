//
//  Constants.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 02.08.2021.
//

import Foundation
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 45
    static let postLabelInsets = UIEdgeInsets(top: 3 + Constants.topViewHeight + 4, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 48
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
}

