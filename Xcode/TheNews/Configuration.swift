//
//  Configuration.swift
//  TheNews
//
//  Created by Daniel on 4/20/20.
//  Copyright © 2020 dk. All rights reserved.
//

import Foundation

struct Configuration {
    static let StyleKey = "style"
    static let CategoryKey = "category"
    static let ApiKey = "8815d577462a4195a64f6f50af3ada08"

    static let StyleDefault: Style = .cnn
    static let CategoryDefault: NewsCategory = .general

    var category: NewsCategory = Configuration.CategoryDefault {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(category.rawValue, forKey: Configuration.CategoryKey)
        }
    }

    var style: Style = Configuration.StyleDefault {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(style.rawValue, forKey: Configuration.StyleKey)
        }
    }

    mutating func loadSaved() {
        category = Configuration.SavedCategory
        style = Configuration.SavedStyle
    }
}

private extension Configuration {
    static var SavedCategory: NewsCategory {
        let defaults = UserDefaults.standard
        if let s = defaults.object(forKey: Configuration.CategoryKey) as? String {
            let style = NewsCategory(rawValue: s)
            if let unwrapped = style {
                return unwrapped
            }
        }

        return Configuration.CategoryDefault
    }

    static var SavedStyle: Style {
        let defaults = UserDefaults.standard
        if let s = defaults.object(forKey: Configuration.StyleKey) as? String {
            let style = Style(rawValue: s)
            if let unwrapped = style {
                return unwrapped
            }
        }

        return Configuration.StyleDefault
    }
}
