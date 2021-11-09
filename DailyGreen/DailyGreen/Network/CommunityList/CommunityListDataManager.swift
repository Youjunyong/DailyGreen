//
//  CommunityListDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/09.
//

import Alamofire

class CommunityListDataManager {
    
    func getCommunityListDetail(delegate: CommunityViewController) {
        
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.TEST_TOKEN] // 테스트 토큰
        AF.request("\(Constant.BASE_URL)/app/communities",
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: CommunityListResponse.self) { response in
                switch response.result{
                case .success(let response):

                    if response.isSuccess, let results = response.result  {
                        var dataList = [CommunityList]()
                        
                        if results.count > 1 {
                            for result in results {
                                var profileUrl = [String]()
                                
                                for url in result.urlList {
                                    profileUrl.append(url.profilePhotoUrl)
                                }
                                dataList.append(CommunityList(name: result.communityName, followers: result.totalFollowers,idx: result.communityIdx , profileUrl: profileUrl))
                            }
                        }
                        delegate.didSuccessGet(message: "성공", dataList: dataList)
                    }

                    else {
                        switch response.code {
                        case 2000: delegate.failedToRequest(message: "2000error")
                        default :
                            delegate.failedToRequest(message: "실패")
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
