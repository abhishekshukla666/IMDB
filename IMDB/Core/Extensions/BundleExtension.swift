//
//  BundleExtension.swift
//  IMDB
//
//  Created by Abhishek Shukla on 15/05/25.
//

import Foundation

extension Bundle {
    static func infoPlistValue(forKey key: String) -> Any? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) else {
           return nil
        }
        return value
    }
}



