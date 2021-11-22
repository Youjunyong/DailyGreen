//
//  EtireShopDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//


import Alamofire

class EntireShopDataManager {
    
    func getEntireShop(delegate: EntireShopViewController, page: Int) {
        
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN] // 테스트 토큰
        AF.request("\(Constant.BASE_URL)/app/shops?page=\(page)",
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: EntireShopResponse.self) { response in
                switch response.result{
                case .success(let response):

                    if response.isSuccess  {
                        let results = response.result
                        delegate.didSuccessGetEntireShop(message: "성공", results: results)
                    }

                    else {
                        switch response.code {
                        case 2000: delegate.failedToRequest(message: "2000error")
                        default :
                            delegate.failedToRequest(message: "실패 code: \(response.code)")
                            break
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))
                    delegate.failedToRequest(message: "서버 연결 원할하지 않음")
                }
            }
    }
}


