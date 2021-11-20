//
//  LikeShopCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//

import Foundation

struct LikeShopRequest: Encodable {
    var shopIdx: Int
}

struct LikeShopResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LikeShopResult
}

struct LikeShopResult: Decodable {
    var isShopLiked: Int
}
