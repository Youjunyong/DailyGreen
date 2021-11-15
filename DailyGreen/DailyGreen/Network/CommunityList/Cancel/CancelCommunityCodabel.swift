//
//  CancelCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import Foundation

struct CancelCommunityRequest: Encodable {
    var communityIdx: String
}

struct CancelCommunityResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
