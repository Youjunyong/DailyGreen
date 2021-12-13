//
//  ParticipateMeetDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/01.
//

import Alamofire

class ParticipateMeetDataManager {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": Constant.shared.JWTTOKEN]

    func particiPateMeet(_ parameters: ParticipateMeetRequest, delegate: MeetDetailViewController) {
        AF.request("\(Constant.BASE_URL)/app/clubs/follow", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: ParticipateMeetResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        var message = ""
                        var bodyMessage = ""
                        switch response.code {
                        case 1017:
                            message = "이벤트에 참가했습니다!"
                            bodyMessage = "오픈채팅링크가 공개됩니다. 멤버들에게 인사해보세요!"
                        case 1018:
                            message = "참여 취소되었습니다."
                            bodyMessage = "무단으로 불참석하는 횟수가 누적되면 서비스 이용에 제한을 받을 수 있습니다."
                        case 1019:
                            message = "이벤트에 재 참가되었습니다."
                            bodyMessage = "참석과 취소를 반복하는 횟수가 누적되면 서비스 이용에 제한을 받을 수 있습니다."
                        default: break
                        }
                        delegate.didSuccessParticiPateMeet(message: message, bodyMessage: bodyMessage)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2031: delegate.failedToRequest(message:  "postIdx를 인식할수 없습니다.")
                        default: delegate.failedToRequest(message: "데이터 베이스 에러")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print(String(describing: error))
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }

    func myPageParticiPateMeet(_ parameters: ParticipateMeetRequest, delegate: MyPageViewController) {
        AF.request("\(Constant.BASE_URL)/app/clubs/follow", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: ParticipateMeetResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessParticiPateMeet(message: response.message)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2031: delegate.failedToRequest(message:  "postIdx를 인식할수 없습니다.")


                        default: delegate.failedToRequest(message: "데이터 베이스 에러")
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
