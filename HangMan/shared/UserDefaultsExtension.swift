//
//  UserDefaultsExtension.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation

extension UserDefaults {

    private enum Keys {
        static let myKey = "myKey"
    }

    class func value<T>(forKey key: String, as type: T.Type) -> T? {
        return UserDefaults.standard.object(forKey: key) as? T
    }

    class func set<T>(_ value: T?, forKey key: String, as type: T.Type) {
        UserDefaults.standard.set(value, forKey: key)
    }

}


// pour utiliser cette extension, il faut faire:
//        if let myValue = UserDefaults.value(forKey: "myKey", as: String.self) {
//            print("Value for myKey: \(myValue)")
//        } else {
//            print("Value for myKey not set")
//        }
//
//        UserDefaults.set("Hello, world!", forKey: "myKey", as: String.self)
