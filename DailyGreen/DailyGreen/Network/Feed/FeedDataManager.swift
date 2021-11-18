//
//  FeedDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/18.
//

import Alamofire

class FeedDataManager {
    
    func getFeedData(delegate: FeedViewController, communityIdx: Int, page: Int) {
        
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.TEST_TOKEN] // 테스트 토큰
        AF.request("\(Constant.BASE_URL)/app/communities/\(communityIdx)/posts?page=1",
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: FeedResponse.self) { response in
                switch response.result{
                case .success(let response):

                    if response.isSuccess  {
                        let results = response.result
                        print(results)
            
                        delegate.didSuccessFeed(message: "성공", results: results)
                    }

                    else {
                        switch response.code {
//                        case 2000: delegate.failedToRequest(message: "2000error")
                        default :
//                            delegate.failedToRequest(message: "실패 code: \(response.code)")
                            break
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))
//                    delegate.failedToRequest(message: "서버 연결 원할하지 않음")
                }
            }
    }
}

