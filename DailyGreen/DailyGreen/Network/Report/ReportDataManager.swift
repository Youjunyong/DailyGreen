//
//  ReportDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/05.
//

import Alamofire

class ReportDataManager {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN] // 테스트 토큰
    
    func reportPost(_ parameters: ReportRequest , delegate: ReportViewController) {
        AF.request("\(Constant.BASE_URL)/app/reports", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: ReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessReport(message: response.message )
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2007: delegate.failedToRequest(message:  "중복된 닉네임 입니다.")
                        
                        
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
    
