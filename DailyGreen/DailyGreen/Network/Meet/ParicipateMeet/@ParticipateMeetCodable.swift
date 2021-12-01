//
//  ParticipateMeetCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/01.
//

import Foundation

struct ParticipateMeetRequest: Encodable {
    var clubIdx: Int
}

struct ParticipateMeetResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
