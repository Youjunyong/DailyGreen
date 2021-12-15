//
//  CommentPostDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/15.
//

import Alamofire

class CommentPostDataManager {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN]
    func postComment(_ parameters: CommentPostRequest, delegate: CommentViewController) {
        AF.request("\(Constant.BASE_URL)/app/comments", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: CommentPostResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        print(response.message)
                        delegate.didSuccessPostComment(message: response.message)
                        
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
