//
//  ShopDetailCodable.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//

import Foundation

struct ShopDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ShopDetailResult?
}

struct ShopDetailResult: Decodable{
    var shopInfoObj: ShopInfoObj?
    var shopPhotoUrlList:  [ShopPhotoUrlList?]
}

struct ShopInfoObj: Decodable{
    var shopIdx: Int
    var userIdx: Int
    var nickname: String
    var profilePhotoUrl: String
    var shopName: String
    var locationDetail: String
    var phoneNum: String
    var website: String
    var bio: String
    var isShopLiked: Int
}

struct ShopPhotoUrlList: Decodable {
    var url: String
}

