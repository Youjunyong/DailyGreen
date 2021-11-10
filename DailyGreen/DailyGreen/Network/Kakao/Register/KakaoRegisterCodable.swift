//
//  KakaoRegisterRequest.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/09.
//

import Foundation

struct KRegisterRequest: Encodable {
    var nickname: String
    var profilePhoto: Data?
    var bio: String
    var accessToken: String
}

struct KRegisterResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UserData?
}

struct UserData: Decodable{
    var userIdx: Int
    var accountIdx: Int
}

