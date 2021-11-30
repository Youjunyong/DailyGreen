//
//  AppleLoginDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/29.
//

import Alamofire

class AppleLoginDataManager {
    
    func postAppleLogin(_ parameters: AppleLoginRequest, delegate: LoginViewController) {
        AF.request("\(Constant.BASE_URL)/app/login/apple", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AppleLoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        let result = response.result
                        guard let jwt = result?.jwt else{return}
                        guard let nickName = result?.nickname else{return}
                        guard let profilePhotoUrl = result?.profilePhotoUrl else{return}
                        guard let userIdx = result?.userIdx else{return}
                        UserDefaults.standard.set(jwt, forKey: "jwt")
                        UserDefaults.standard.set(nickName, forKey: "nickName")
                        UserDefaults.standard.set(profilePhotoUrl, forKey: "profilePhotoUrl")
                        UserDefaults.standard.set(userIdx, forKey: "userIdx")

                        UserDefaults.standard.set("apple", forKey:"way")
                        
                        delegate.successAppleLogin(message: response.message)
                        
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {

                        case 3007: delegate.failedToAppleLogin(message: "존재하지 않는 계정입니다. 회원가입을 해주세요." , appleToken: parameters.accessToken)
                        case 4000: delegate.failedToAppleLogin(message: "데이터 베이스 에러",appleToken: parameters.accessToken)
                        default: delegate.failedToAppleLogin(message: "code : \(response.code)",appleToken: parameters.accessToken)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))

//                    delegate.failedToAppleLogin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
    
