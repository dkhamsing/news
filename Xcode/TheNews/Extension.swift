//
//  Extension.swift
//  TheNews
//
//  Created by Daniel on 4/12/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

extension Article {
    var profileImage: UIImage? {
        guard let name = source?.name,
            let first = name.first else { return nil }

        let systemName = "\(first).circle.fill".lowercased()
        return UIImage(systemName: systemName)
    }
}

extension Date {
    func shortTimeAgoSinceDate() -> String {
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
}

extension UIColor {
    static func colorFor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
    }
}

// Credits: https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints
extension UIAlertController {
    func fixiOSAutolayoutNegativeConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}

extension UIView {
    func autolayoutAddSubview(_ view: UIView) {
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
