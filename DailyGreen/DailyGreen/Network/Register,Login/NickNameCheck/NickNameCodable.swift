//
//  NickNameCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//

import Foundation


struct NickNameRequest: Encodable {
    var nickname: String
}

struct NickNameResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: String?
}


