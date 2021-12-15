//
//  CommentPostCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/15.
//

import Foundation


struct CommentPostRequest: Encodable {
    var postIdx: Int
    var content: String
}
struct CommentPostResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
