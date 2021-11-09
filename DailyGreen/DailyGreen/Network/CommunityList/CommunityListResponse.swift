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
    var communityName: String
    var totalFollowers: Int
    var urlList: [UrlList]
}

struct UrlList: Decodable {
    var profilePhotoUrl : String
}

//{
//    "isSuccess": true,
//    "code": 1000,
//    "message": "성공",
//    "result": [
//        {
//            "communityIdx": 1,
//            "communityName": "플로깅",
//            "totalFollowers": 2,
//            "urlList": [
//                {
//                    "profilePhotoUrl": "URL"
//                },
//                {
//                    "profilePhotoUrl": "URL"
//                }
//            ]
//        },
//        {
//            "communityIdx": 2,
//            "communityName": "제로웨이스트",
//            "totalFollowers": 1,
//            "urlList": [
//                {
//                    "profilePhotoUrl": "URL"
//                }
//            ]
//        },
//        {
//            "communityIdx": 3,
//            "communityName": "분리배출",
//            "totalFollowers": 1,
//            "urlList": [
//                {
//                    "profilePhotoUrl": "URL"
//                }
//            ]
//        }
//    ]
//}
