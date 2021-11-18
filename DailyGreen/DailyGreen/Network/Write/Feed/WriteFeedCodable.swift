//
//  WriteFeedCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/17.
//

import Foundation

struct WriteFeedRequest: Encodable {
    var communityIdx: Int
    var caption: String
    var photos: [Data]
}

struct WriteFeedResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
