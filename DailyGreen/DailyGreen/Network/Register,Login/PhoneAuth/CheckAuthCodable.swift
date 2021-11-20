//
//  CheckAuthCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import Foundation


struct CheckAuthRequest: Encodable {
    var phoneNumber: String
    var verifyCode: String
}

struct CheckAuthResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
