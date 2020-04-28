//
//  TvExtension.swift
//  TheNews.tvos
//
//  Created by Daniel on 4/28/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

extension UIView {
    func addGradientLeftRight() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addTvCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
