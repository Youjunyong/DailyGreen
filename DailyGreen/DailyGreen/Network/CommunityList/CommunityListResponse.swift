//
//  NickNameDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//

import Alamofire

struct CommunityListResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [Result]?
}

struct Result: Decodable {
    var communityIdx: Int
    var communityName: String?
    var totalFollowers: Int
    var urlList: [UrlList]
}

struct UrlList: Decodable {
    var profilePhotoUrl : String
}
