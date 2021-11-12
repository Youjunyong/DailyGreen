//
//  CheckAuthDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import Alamofire

class CheckAuthDataManager {
    
    func checkPhoneAuth(_ parameters: CheckAuthRequest, delegate: RegisterPhoneViewController) {
        AF.request("\(Constant.BASE_URL)/app/users/auth/verify", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: CheckAuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        let result = response.message
                        delegate.successCheckAuth(message: result)
                        print(#function)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                        case 2037: delegate.failedPostPhoneAuth(message: "인증 요청 내역이 없습니다, 인증번호를 다시 요청해주세요")
                        case 2038: delegate.failedPostPhoneAuth(message: "인증번호가 일치하지 않습니다.")
                        case 4000: delegate.failedPostPhoneAuth(message: "데이터베이스 에러")
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
    
