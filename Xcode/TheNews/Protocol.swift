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

protocol Selectable {
    func didSelect(_ string: String)
}
