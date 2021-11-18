//
//  LikeCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/18.
//

import Foundation

struct LikeRequest: Encodable {
    var postIdx: Int
}

struct LikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LikeResult
}

struct LikeResult: Decodable {
    var isPostLiked: Int
}
