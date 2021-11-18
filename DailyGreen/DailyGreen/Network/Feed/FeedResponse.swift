//
//  FeedResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/18.
//

import Foundation

struct FeedResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [FeedResult?]
}

struct FeedResult: Decodable{
    let postInfoObj: PostInfoObj?
    let postPhotoUrlListObj: PostPhtoUrlListObj?
}

struct PostInfoObj: Decodable {
    var userIdx: Int
    var nickname: String
    var profilePhotoUrl: String
    var postIdx: Int
    var caption: String
    var isFollowing: Int
    var isPostLiked: Int
    var postLikeTotal: Int
    var commentTotal: Int
    
}


struct PostPhtoUrlListObj: Decodable {
    var postIdx: Int
    var urlList: [FeedUrl]
    
}
struct FeedUrl: Decodable {
    var url: String
}
