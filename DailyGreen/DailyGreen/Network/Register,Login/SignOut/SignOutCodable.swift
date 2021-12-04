//
//  SignOutCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/03.
//

import Foundation

struct SignOutRequest: Encodable {
    var userIdx: Int
}

struct SignOutResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
