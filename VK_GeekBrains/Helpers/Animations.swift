//
//  Animations.swift
//  VK_GeekBrains
//
//  Created by Роман Шичкин on 08.08.2021.
//

import Foundation
import UIKit

extension UIView {
    func pushTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }

}

extension UITableViewCell {
    func imageAnimate(imageView: UIImageView) {
        let anime = CASpringAnimation(keyPath: "transform.scale")
        anime.fromValue = 0.8
        anime.toValue = 1
        anime.stiffness = 100
        anime.mass = 1
        anime.duration = 5
        anime.beginTime = CACurrentMediaTime()
        anime.fillMode = CAMediaTimingFillMode.backwards
        imageView.layer.add(anime, forKey: nil)
    }
}

