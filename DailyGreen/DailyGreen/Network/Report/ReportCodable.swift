//
//  ReportCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/05.
//

import Foundation

struct ReportRequest: Encodable {
    var idx: Int
    var sort: String
    var content: String
}

struct ReportResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
