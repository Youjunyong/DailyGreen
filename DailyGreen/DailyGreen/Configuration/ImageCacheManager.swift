//
//  Cache.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit


class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}



