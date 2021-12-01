//
//  ParticipateMeetDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/01.
//

import Alamofire

//class ParticipateMeetDataManager {
//    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN]
//    
//    func particiPateMeet(_ parameters: ParticipateMeetRequest, delegate: ) {
//        AF.request("\(Constant.BASE_URL)/app/clubs/follow", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
//            .validate()
//            .responseDecodable(of: LikeShopResponse.self) { response in
//                switch response.result {
//                case .success(let response):
//                    // 성공했을 때
//                    if response.isSuccess {
//                        delegate.didSuccessLikeShop(message: response.message)
//                    }
//                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        case 2031: delegate.failedToRequest(message:  "postIdx를 인식할수 없습니다.")
//                        
//                        
//                        default: delegate.failedToRequest(message: "데이터 베이스 에러")
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    print(String(describing: error))
//                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
//                }
//            }
//    }
//    
//    
//    
//}
