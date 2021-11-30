//
//  EmailLoginDataManger.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/20.
//

import Alamofire
class EmailLoginDataManager {
    
    func postEmailLogin(_ parameters: EmailLoginRequest, delegate: EmailLoginViewController) {
        AF.request("\(Constant.BASE_URL)/app/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmailLoginResponse.self) { response in
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
                        UserDefaults.standard.set("email", forKey: "way")
                        UserDefaults.standard.set(nickName, forKey: "nickName")
                        UserDefaults.standard.set(userIdx, forKey: "userIdx")

                        UserDefaults.standard.set(profilePhotoUrl, forKey: "profilePhotoUrl")
                        delegate.successEmailLogin(message: "로그인 성공")
                        
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2041: delegate.failedToEmailLogin(message: "이메일을 입력해주세요.")
                        case 2042: delegate.failedToEmailLogin(message: "비밀번호를 다시 입력해주세요.")
                        case 2044: delegate.failedToEmailLogin(message: "이메일을 다시 입력해주세요.")
                        case 3004: delegate.failedToEmailLogin(message: "비밀번호를 다시 입력해주세요.")
                        case 3007: delegate.failedToEmailLogin(message: "존재하지 않는 계정입니다. 회원가입을 해주세요.")
                        case 4000: delegate.failedToEmailLogin(message: "데이터 베이스 에러")
                        default: delegate.failedToEmailLogin(message: "데이터 베이스 에러")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))

                    delegate.failedToEmailLogin(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
}
