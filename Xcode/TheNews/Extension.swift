//
//  Extension.swift
//  TheNews
//
//  Created by Daniel on 4/12/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

extension NewsApi {
    static func getArticles(url: URL?, completion: @escaping ([Article]?) -> Void) {
        url?.get(completion: { (result: Result<Headline, ApiError>) in
            switch result {
            case .success(let headline):
                completion(headline.articles)
            case .failure(_):
                completion(nil)
            }
        })
    }
}

extension Date {
    var shortTimeAgoSinceDate: String {
        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return "\(interval)y"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return "\(interval)mo"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return "\(interval)d"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return "\(interval)h"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return "\(interval)m"
        }

        return "a moment ago"
    }
    
    var timeAgoSinceDate: String {
        let dateFormatter = RelativeDateTimeFormatter()

        return dateFormatter.localizedString(for: self, relativeTo: Date())
    }
}

extension UIColor {
    static func colorFor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }

    static func colorForSameRgbValue(_ value: CGFloat) -> UIColor {
        return colorFor(red: value, green: value, blue: value)
    }
}

// Credits: https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints
extension UIAlertController {
    func fixiOSAlertControllerAutolayoutConstraint() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}

extension UIView {
    func addSubviewForAutoLayout(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
