//
//  KakaoLoginCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/14.
//

import Foundation

struct KakaoLoginRequest: Encodable {
    var accessToken: String
}

struct KakaoLoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LoginData?
}

struct LoginData: Decodable {
    var nickname: String
    var profilePhotoUrl: String
    var jwt: String
    var userIdx: Int?
}
