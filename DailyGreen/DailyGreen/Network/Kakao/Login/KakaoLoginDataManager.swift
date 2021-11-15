//
//  KakaoLoginDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/14.
//

import Alamofire

class KakaoLoginDataManager {
    
    func postKakaoLogin(_ parameters: KakaoLoginRequest, delegate: LoginViewController) {
        AF.request("\(Constant.BASE_URL)/app/login/kakao", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: KakaoLoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        let result = response.result
                        
                        
                        print("내 카카오 jwt ? ",result?.jwt)
                        guard let jwt = result?.jwt else{return}
                        guard let nickName = result?.nickname else{return}
                        guard let profilePhotoUrl = result?.profilePhotoUrl else{return}
                        UserDefaults.standard.set(jwt, forKey: "jwt")
                        UserDefaults.standard.set(nickName, forKey: "nickName")
                        UserDefaults.standard.set(profilePhotoUrl, forKey: "profilePhotoUrl")
                        delegate.successKakaoLogin(message: response.message)
                        
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2009: delegate.failedToKakaoLogin(message: "엑세스 토큰을 입력해주세요")
                        case 3007: delegate.failedToKakaoLogin(message: "존재하지 않는 계정입니다. 회원가입을 해주세요.")
                        case 4000: delegate.failedToKakaoLogin(message: "데이터 베이스 에러")
                        default: delegate.failedToKakaoLogin(message: "code : \(response.code)")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))

                    delegate.failedToKakaoLogin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    
    
}
    
