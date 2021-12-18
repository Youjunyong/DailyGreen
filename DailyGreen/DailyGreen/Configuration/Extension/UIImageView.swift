//
//  UIImage.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit

extension UIImageView{
    
    func load(strUrl: String) {
        let cacheKey = NSString(string: strUrl) // 캐시에 사용될 Key 값
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            self.image = cachedImage
            return
        }
        guard let url = URL(string: strUrl) else{return}
        DispatchQueue.global().async {
            [weak self] in if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                    }
                }
            }
        }
    }
}

