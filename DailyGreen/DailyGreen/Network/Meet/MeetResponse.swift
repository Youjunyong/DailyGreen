//
//  MeetRequest.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/14.
//

import Foundation

struct ClubResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ClubInfo?]
}

struct ClubInfo: Decodable {
    var clubInfoObj: ClubInfoObejct
    var profilePhotoUrlListObj: ClubImageList
    var clubTagListObj: ClubTagListObj
}


struct ClubInfoObejct: Decodable {
    var clubIdx: Int
    var userIdx: Int
    var nickname: String
    var profilePhotoUrl: String
    var clubName: String
    var locationDetail: String
    var maxPeopleNum : Int
    var bio: String
    var when: String
    var Dday: String
    var clubPhoto: String
    var nowFollowing: Int
    
}

struct ClubImageList: Decodable {
    var clubIdx: Int
    var urlList: [ProfilePhotoUrl]
}

struct ProfilePhotoUrl: Decodable {
    var profilePhotoUrl: String
}

struct ClubTagListObj: Decodable {
    var clubIdx: Int
    var tagList: [TagName]
}

struct TagName: Decodable{
    var tagName: String
}
