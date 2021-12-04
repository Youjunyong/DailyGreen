//
//  EmailRegisterCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/20.
//

import Foundation

struct EmailRegisterRequest: Encodable {
    var email: String
    var nickname: String
    var password: String
    var phoneNum: String
    var profilePhoto: Data?
    var bio: String
}

struct EmailRegisterResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: EmailRegisterUserData?
}

struct EmailRegisterUserData: Decodable{
    var userIdx: Int
    var accountIdx: Int
}

struct UpdateProfileResponse: Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UpdateUserData?
}

struct UpdateUserData: Decodable{
    var profilePhotoUrl: String
}
