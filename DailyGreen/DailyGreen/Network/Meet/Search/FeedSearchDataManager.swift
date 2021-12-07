//
//  FeedSearchDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/05.
//

import Alamofire

class FeedSearchDataManager {
    
    func getFeedSearchData(delegate: FeedViewController, communityIdx: Int, page: Int, keyword: String) {
        
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN]
        let urlString = "\(Constant.BASE_URL)/app/communities/\(communityIdx)/posts/searches?keyword=\(keyword)&page=1"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        AF.request(url,
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
                        
                        delegate.didSuccessFeed(message: "성공", results: results, keyword: keyword)
                    }

                    else {
                        switch response.code {
                        case 2000: delegate.failedToRequest(message: "2000error")
                        default :
                            delegate.failedToRequest(message: "실패 code: \(response.code)")
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
