//
//  PhoneAuthDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import Alamofire

class PhoneAuthDataManager {
    
    func postPhoneAuth(_ parameters: PhoneAuthRequest, delegate: RegisterPhoneViewController) {
        AF.request("\(Constant.BASE_URL)/app/users/auth", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: PhoneAuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        let result = response.message
                        delegate.successPhoneAuth(message: result)
                        print(#function)

                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        case 3012: delegate.failedPostPhoneAuth(message: "SMS 문자 전송 실패")
                        case 4000: delegate.failedPostPhoneAuth(message: "데이터 베이스 에러")
                        default: delegate.failedPostPhoneAuth(message: "code : \(response.code)")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))

                    delegate.failedPostPhoneAuth(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
}
    
