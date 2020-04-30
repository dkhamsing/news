//
//  Settings.swift
//  TheNews
//
//  Created by Daniel on 4/20/20.
//  Copyright © 2020 dk. All rights reserved.
//

import Foundation

struct Settings {
    static let StyleKey = "style"
    static let CategoryKey = "category"
    static let ApiKey = "8815d577462a4195a64f6f50af3ada08"

    static let StyleDefault: Style = .cnn
    static let CategoryDefault: NewsCategory = .general

    var category: NewsCategory = UserDefaultsConfig.savedCategory {
        didSet {
            UserDefaultsConfig.savedCategory = category
        }
    }

    var style: Style = UserDefaultsConfig.savedStyle {
        didSet {
            UserDefaultsConfig.savedStyle = style
        }
    }
}

struct UserDefaultsConfig {
    @UserDefault(Settings.CategoryKey, defaultValue: Settings.CategoryDefault)
    static var savedCategory: NewsCategory

    @UserDefault(Settings.StyleKey, defaultValue: Settings.StyleDefault)
    static var savedStyle: Style
}
