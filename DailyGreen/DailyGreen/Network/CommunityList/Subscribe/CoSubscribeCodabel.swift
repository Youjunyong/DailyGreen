//
//  CoSubscribeCodabel.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import Foundation


struct CoSubscribeRequest: Encodable {
    var communityIdx: String
}

struct CoSubscribeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}


