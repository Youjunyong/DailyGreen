//
//  PhoneAuthCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import Foundation

struct PhoneAuthRequest: Encodable {
    var phoneNumber: String
}

struct PhoneAuthResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    
}
