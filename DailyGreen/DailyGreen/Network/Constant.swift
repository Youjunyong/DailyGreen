//
//  Constant.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//


import Foundation


class Constant {

    static let shared = Constant()
    static let BASE_URL = "https://ssac-ivy.shop"
    var JWTTOKEN: String = UserDefaults.standard.string(forKey: "jwt")!


    private init() { }
}
