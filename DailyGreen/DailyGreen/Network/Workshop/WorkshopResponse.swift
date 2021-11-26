//
//  WorkshopResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/25.
//

import Foundation


struct WorkshopResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [WorkshopInfo?]
}

struct WorkshopInfo: Decodable {
    var workshopInfoObj: WorkshopInfoObject
    var profilePhotoUrlListObj: WorkshopImageList?
    var workshopTagListObj: WorkshopTagListObj?

}

struct WorkshopInfoObject: Decodable {
    var workshopIdx: Int
    var userIdx: Int
    var nickname: String
    var profilePhotoUrl: String
    var workshopName: String
    var locationDetail: String
    var maxPeopleNum : Int
    var bio: String
    var when: String
    var Dday: String
    var workshopPhoto: String
    var nowFollowing: Int
    
}

struct WorkshopImageList: Decodable {
    var workshopIdx: Int?
    var urlList: [ProfilePhotoUrl?]?
}

struct WorkshopTagListObj: Decodable {
    var workshopIdx: Int?
    var tagList: [TagName?]?
}

