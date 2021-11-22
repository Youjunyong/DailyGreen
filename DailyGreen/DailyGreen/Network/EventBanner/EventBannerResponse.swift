//
//  EventBannerResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import Foundation

struct EventBannerResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [EventBannerResult]
}

struct EventBannerResult: Decodable{
    var idx: Int
    var communityIdx: Int
    var name: String
    var locationDetail: String
    var when: String
    var Dday: Int
    var photo: String
    var type: String
}
