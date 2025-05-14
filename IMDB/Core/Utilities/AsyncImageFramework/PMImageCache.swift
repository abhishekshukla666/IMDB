//
//  PMImageCache.swift
//  IMDB
//
//  Created by Abhishek Shukla on 05/05/25.
//


import Foundation

class PMImageCache {
    
    typealias Cachetype = NSCache<NSString, NSData>
    
    static let shared = PMImageCache()
    
    private init() {}
    
    private lazy var cache: Cachetype = {
        let cache = Cachetype()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()
    
    func object(forKey key: String) -> Data? {
        cache.object(forKey: key as NSString) as? Data
    }
    
    func setObject(_ object: Data, forKey key: String) {
        cache.setObject(object as NSData, forKey: key as NSString)
    }
}
