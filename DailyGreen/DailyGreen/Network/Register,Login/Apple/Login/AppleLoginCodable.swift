//
//  AppleLoginCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/29.
//

import Foundation

struct AppleLoginRequest: Encodable {
    var accessToken: String
}

struct AppleLoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: AppleLoginData?
}

struct AppleLoginData: Decodable {
    var nickname: String
    var profilePhotoUrl: String
    var jwt: String
    var userIdx: Int?

}
