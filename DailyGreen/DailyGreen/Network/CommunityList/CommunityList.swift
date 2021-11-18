//
//  CommunityList.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/09.
//

import Foundation

struct CommunityList {
    var name: String
    var followers: Int
    var idx : Int
    var profileUrl: [String]
    
}

class CommunityData {
    static let shared = CommunityData()
    
    var subscribedList = [Int]()
    let nameArr = ["","플로깅", "제로웨이스트", "분리배출", "비건레시피", "에너지,물절약", "업사이클링", "차없이 가기", "환경문화"]
    let subTitleArr = ["", "운동을 좋아하는 그린이에게 추천!", "일상 속에서 계속 나오는 쓰레기에 진절머리가 난 그린이에게 추천! ", "내가 버린 쓰레기가 재탄생 되는 것을 보고 싶은 그린이에게 추천!" , "건강을 생각하고 동물이 아프지 않는 요리를 먹고 싶은 그린이에게 추천!" ,"환경보호를 하면서 생활비를 같이 절약하고 싶은 그린이에게 추천!", "버려지는 물건에 새로운 가치를 주어 재활용하고 싶은 그린이에게 추천!", "산책을 좋아하는 그린이에게 추천!","여러 환경적 이슈를 더 알고 싶어하는 그린이에게 추천! "]
    let imageArr = ["", "grid00", "grid01" , "grid02" , "grid10", "grid12", "grid20", "grid21", "grid22"]
    
    private init(){}
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
