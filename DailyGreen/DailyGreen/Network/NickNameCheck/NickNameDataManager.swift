//
//  NickNameDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//

import Alamofire

class NickNameDataManager {
    
    func postNickName(_ parameters: NickNameRequest, delegate: RegisterProfileViewController) {
        AF.request("\(Constant.BASE_URL)/app/users/nicknames", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: NickNameResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        let result = response.message
                        delegate.didSuccessPost(message: result)
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2007: delegate.failedToRequest(message: "중복된 닉네임 입니다.")
                        case 2008: delegate.failedToRequest(message: "닉네임은 9자리 미만으로 입력해주세요.")
                        case 4000: delegate.failedToRequest(message: "데이터 베이스 에러")
                        default: delegate.failedToRequest(message: "code : \(response.code)")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))

                    delegate.failedToRequest(message: ".ㄹ먀ㅣㅕㄱㄷ서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
