//
//  EmailLoginCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/20.
//

import Foundation

struct EmailLoginRequest: Encodable {
    var email: String
    var password: String
}

struct EmailLoginResponse: Decodable {
    var code: Int
    var message: String
    var isSuccess: Bool
    var result: EmailLoginResult?
}

struct EmailLoginResult: Decodable{
    var nickname: String
    var profilePhotoUrl: String
    var jwt: String
    var userIdx: Int?

}
