//
//  LikeDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/18.
//

import Alamofire

class LikeDataManager {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.TEST_TOKEN]
    func postLike(_ parameters: LikeRequest, delegate: FeedViewController) {
        AF.request("\(Constant.BASE_URL)/app/posts/likes", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: LikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        
                        delegate.didSuccessLike(message: response.message)
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2007: delegate.failedToRequest(message:  "\(#function) 중복된 닉네임 입니다.")
                        
                        
                        default: delegate.failedToRequest(message: "else-default | code : \(response.code)")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
