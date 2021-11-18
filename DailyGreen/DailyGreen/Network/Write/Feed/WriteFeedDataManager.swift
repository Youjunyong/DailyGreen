//
//  WriteFeedDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/17.
//

import Alamofire


class WriteFeedDataManager {
    
    func uploadFeed(params: WriteFeedRequest, delegate: WriteFeedViewController){
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data",
               "X-ACCESS-TOKEN": Constant.TEST_TOKEN
           ]        

           AF.upload(multipartFormData: { multiPart in
               
               multiPart.append(Data(String(params.communityIdx).utf8), withName: "communityIdx")
               multiPart.append(Data(params.caption.utf8), withName: "caption")
               
               for (idx,image) in params.photos.enumerated() {
                   multiPart.append(image, withName: "photos", fileName: "\(idx).jpg", mimeType: "image/jpeg")
                   
               }
           }, to: "\(Constant.BASE_URL)/app/posts"
            , headers: headers)
               .uploadProgress(queue: .main, closure: { progress in
                   //Current upload progress of file
                   print("Upload Progress: \(progress.fractionCompleted)")
               })
               .validate()
               .responseDecodable(of: WriteFeedResponse.self) { response in
                   switch response.result {
                   case .success(let response):
                       // 성공했을 때
                       if response.isSuccess {
                           let result = response.message
                           print(result)
                           delegate.successWriteFeed(message: result)
                           
                       }
                       // 실패했을 때
                       else {
                           switch response.code {
                           case 2007: delegate.failedToWrite(message: "중복된 닉네임 입니다.")
                           case 2008: delegate.failedToWrite(message: "닉네임은 9자리 미만으로 입력해주세요.")
                           case 4000: delegate.failedToWrite(message: "데이터 베이스 에러")
                           default:
                               print("#")
                               delegate.failedToWrite(message: "code : \(response.code)")
                           }
                       }
                   case .failure(let error):
                       print(error.localizedDescription)
                       print(String(describing: error))

                       delegate.failedToWrite(message: "서버와의 연결이 원활하지 않습니다")
                   }
               }
       }

    
    
    
}
    
