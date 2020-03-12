//
//  ImageCache.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

final class ImageCache {
    
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?

    static let shared = ImageCache()

    private init() {
        // make sure to purge cache on memory pressure
        let urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024,
                                diskCapacity: 50 * 1024 * 1024,
                                diskPath: nil)
        URLCache.shared = urlCache
        
        observer = NotificationCenter.default
            .addObserver(forName: UIApplication.didReceiveMemoryWarningNotification,
                         object: nil,
                         queue: nil,
                         using: { [weak self] _ in
                            guard let self = self else { return }
                            self.cache.removeAllObjects()
            })
    }

    deinit {
        NotificationCenter.default.removeObserver(observer as Any)
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
