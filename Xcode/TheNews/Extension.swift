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

extension Bundle {

    static var nameSpace: String? {
        guard let info = Bundle.main.infoDictionary,
              let projectName = info["CFBundleExecutable"] as? String else { return nil }

        let nameSpace = projectName.replacingOccurrences(of: "-", with: "_")

        return nameSpace
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

// Credits: https://github.com/onodude/OnoKit-iOS
extension UICollectionView {

    convenience init(frame: CGRect, direction: UICollectionView.ScrollDirection, identifiers: [String]) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        layout.minimumLineSpacing = 0

        self.init(frame: frame, collectionViewLayout: layout)

        guard let nameSpace = Bundle.nameSpace else { return }

        for identifier in identifiers {
            if let anyClass: AnyClass = NSClassFromString("\(nameSpace).\(identifier)") {
                self.register(anyClass, forCellWithReuseIdentifier: identifier)
            }
        }
    }

}

// Credits: https://github.com/onodude/OnoKit-iOS
extension UITableView {

    convenience init(frame: CGRect, style: UITableView.Style, identifiers: [String]) {
        self.init(frame: frame, style: style)

        guard let nameSpace = Bundle.nameSpace else { return }

        for identifier in identifiers {
            if let anyClass: AnyClass = NSClassFromString("\(nameSpace).\(identifier)") {
                self.register(anyClass, forCellReuseIdentifier: identifier)
            }
        }
    }

}

extension UIView {
    func addSubviewForAutoLayout(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func addGradient(count: Int, index: UInt32) {
//        print(self.layer.sublayers?.count)

        if self.layer.sublayers == nil {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            self.layer.insertSublayer(gradientLayer, at: index)
            return
        }

        guard self.layer.sublayers?.count == count else { return }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.layer.insertSublayer(gradientLayer, at: index)
    }

}
