//
//  EntireShopCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//

import Foundation

struct EntireShopResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [EntireShopResult?]
}

struct EntireShopResult: Decodable{
    var shopIdx: Int
    var shopName: String
    var locationDetail: String
    var url: String
    var isShopLiked: Int
}

