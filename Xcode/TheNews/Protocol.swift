//
//  Protocol.swift
//  TheNews
//
//  Created by Daniel on 4/12/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

protocol Configurable {
    func setup()
    func config()
}

protocol Displayable {
    static var ReuseIdentifier: String { get }
    static var ImageSize: CGSize  { get }
    var identifier: String? { get set }

    func configure(_ article: Article)
    func update(image: UIImage?, identifier ident: String?)
}

protocol Selectable {
    func didSelect(_ string: String)
}
