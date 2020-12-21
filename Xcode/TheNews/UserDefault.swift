//
//  UserDefault.swift
//  TheNews
//
//  Created by Daniel on 4/30/20.
//  Copyright © 2020 dk. All rights reserved.
//

import Foundation

// Credits: https://www.avanderlee.com/swift/property-wrappers/
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
            guard let saved = UserDefaults.standard.object(forKey: key) as? Data,
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
