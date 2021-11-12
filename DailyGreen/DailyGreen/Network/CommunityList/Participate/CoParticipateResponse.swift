//
//  CoParticipateResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import Foundation

struct CoParticipateResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: CoPResult?
}

struct CoPResult: Decodable {
    var totalFollowers: Int
    var urlList: [UrlList]
}

//struct UrlList: Decodable {
//    var profilePhotoUrl : String
//}
