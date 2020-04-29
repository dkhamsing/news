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

// Credits: https://www.avanderlee.com/swift/property-wrappers/
struct UserDefaultsConfig {
    @UserDefault(Configuration.CategoryKey, defaultValue: Configuration.CategoryDefault)
    static var savedCategory: NewsCategory

    @UserDefault(Configuration.StyleKey, defaultValue: Configuration.StyleDefault)
    static var savedStyle: Style
}

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard
                let saved = UserDefaults.standard.object(forKey: key) as? Data,
                let decoded = try? JSONDecoder().decode(T.self, from: saved) else { return defaultValue }
            return decoded
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}
