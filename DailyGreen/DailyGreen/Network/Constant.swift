//
//  Constant.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//


import Foundation

struct Constant {
    static let BASE_URL = "https://ssac-ivy.shop"
    static let TEST_TOKEN = UserDefaults.standard.string(forKey: "jwt") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4Ijo1LCJpYXQiOjE2MzU5MzIwMDksImV4cCI6MTY2NzQ2ODAwOSwic3ViIjoidXNlckluZm8ifQ.FVwndlSZT9oaSScp_uPdcEY-j-o3di_vQEHwnkI8lHY"
}

//class Constant {
//    
//    static let shared = Constant()
//    
//    var JWTToken: String? = UserDefaults.standard.string(forKey: "JWT") {
//        didSet {
//            guard let JWTToken = JWTToken else { return }
//            UserDefaults.standard.setValue(JWTToken, forKey: "JWT")
//        }
//    }
//
//    var passedData: String = ""
//    
//    private init() { } // 여러개생성 방지
//}
