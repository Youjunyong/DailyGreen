//
//  SignOutDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/03.
//

import Alamofire

class SignOutDataManager {
    
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN]
    func patchSignOut(_ parameters: SignOutRequest, delegate: LogoutSignOutViewController, userIdx: Int) {
        AF.request("\(Constant.BASE_URL)/app/users/\(userIdx)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: SignOutResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.successToSignOut(message: response.message)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2007: delegate.failedToRequest(message:  "\(#function) 중복된 닉네임 입니다.")
                        
                        
                        default: delegate.failedToRequest(message: "\(response.message)")
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





