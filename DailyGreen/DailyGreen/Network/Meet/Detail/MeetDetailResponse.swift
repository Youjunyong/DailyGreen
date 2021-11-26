//
//  MeetDetailResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import Foundation

struct MeetDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: MeetDetailResult?
}

struct MeetDetailResult: Decodable{
    var clubInfoObj: ClubInfoObj?
    var clubPhotoUrlListObj:  ClubPhotoUrlListObj?
    var participantListObj: ParticipantListObj?
    var clubTagListObj: ClubTagListMObj?
}

struct ClubInfoObj: Decodable{
    var clubIdx: Int
    var userIdx: Int
    var nickname: String
    var profilePhotoUrl: String
    var clubName: String
    var locationDetail: String
    var maxPeopleNum: Int
    var bio: String
    var when: String
    var Dday: String
    var feeType: String
    var fee: String
    var nowFollowing: Int
}

struct ClubPhotoUrlListObj: Decodable {
//    var clubIdx: Int?
    var urlList: [ClubPhotoUrl?]
}

struct ClubPhotoUrl: Decodable {
    var clubPhotoUrl: String
}

struct ParticipantListObj: Decodable{
//    var clubIdx: Int?
    var participants: [Participants?]?
}

struct Participants: Decodable{
    var profilePhotoUrl: String
    var nickname: String
}
struct ClubTagListMObj: Decodable{
//    var clubIdx: Int?
    var tagList: [TagList?]?
}

struct TagList: Decodable{
    var tagName: String
}
