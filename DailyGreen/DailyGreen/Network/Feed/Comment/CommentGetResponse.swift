//
//  CommentGetResponse.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/15.
//

import Foundation

struct CommentGetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [Comments]
}

struct Comments: Decodable{
    var content: String?
    var nickname: String
    var profilePhotoUrl: String
    var agoTime: String
}

