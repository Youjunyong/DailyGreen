//
//  AppleReigsterCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/29.
//


import Foundation

struct AppleRegisterRequest: Encodable {
    var nickname: String
    var profilePhoto: Data?
    var bio: String
    var accessToken: String
}

struct AppleRegisterResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: AppleUserData?
}

struct AppleUserData: Decodable{
    var userIdx: Int
    var accountIdx: Int
    
    var nickname: String
    var profilePhotoUrl: String
    var jwt: String

}

