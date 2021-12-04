//
//  MyPageGetResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/25.
//

import Foundation

struct MyPageGetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: InfoResult
}

struct InfoResult: Decodable{
    var myInfo: MyInfo
    var participatingInfo: [ParticipatingInfo?]
    var createdInfo: [CreatedInfo?]
}

struct MyInfo: Decodable{
    var userIdx : Int
    var nickname: String
    var profilePhotoUrl: String
    var participationCnt: Int
    var createdPostCnt: Int
    var badgeCnt: Int
    var bio: String
    var exp: Int
}

struct ParticipatingInfo: Decodable {
    var idx: Int
    var type: String
    var name: String
    var when: String
    var locationDetail: String
//    var Dday : Int
    
}

struct CreatedInfo: Decodable{
    var idx: Int?
    var type: String?
    var name: String?
    var when: String?
    var locationDetail: String?
}




//isSuccess    boolean
//code    int
//message    String
//result    object
//ㄴmyInfo    object
//    ㄴuserIdx    int
//    ㄴnickname    String
//    ㄴprofilePhotoUrl    String
//    ㄴparticipationCnt    int
//    ㄴcreatedPostCnt    int
//    ㄴbadgeCnt    int
//    ㄴexp    int
//ㄴparticipatingInfo    object
//    ㄴidx    int
//    ㄴtype    String
//    ㄴname    String
//    ㄴwhen    String
//    ㄴlocationDetail    String
//    ㄴDday    int
