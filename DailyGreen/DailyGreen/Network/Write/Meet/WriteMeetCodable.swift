//
//  WriteMeetCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import Foundation


struct WriteMeetRequest: Encodable {
    var photos: [Data]
    var communityIdx: Int
    var name: String
    var tagList: [String?]
    var bio: String
    var maxPeopleNum: Int
    var feeType: String
    var fee: String
    var kakaoChatLink: String
    var isRegular: Int
    var locationIdx: Int
    var locationDetail: String
    var when: String
    
}



struct WriteMeetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
