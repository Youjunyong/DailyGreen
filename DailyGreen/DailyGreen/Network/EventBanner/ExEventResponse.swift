//
//  ExEventResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2022/02/02.
//

import Foundation

struct ExEventBannerResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ExEventBannerResult]
}

struct ExEventBannerResult: Decodable{
    var addIdx: Int
    var addUrl: String
    var linkedUrl: String
}
