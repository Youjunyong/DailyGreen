//
//  WriteMeetDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import Alamofire


class WriteMeetDataManager {

    func uploadFeed(params: WriteMeetRequest, delegate: WriteDateLocationViewController){
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data",
               "X-ACCESS-TOKEN": Constant.shared.JWTTOKEN
           ]

           AF.upload(multipartFormData: { multiPart in

               multiPart.append(Data(String(params.communityIdx).utf8), withName: "communityIdx")
               multiPart.append(Data(params.name.utf8), withName: "name")
               multiPart.append(Data(params.bio.utf8), withName: "bio")
               multiPart.append(Data(String(params.maxPeopleNum).utf8), withName: "maxPeopleNum")
               multiPart.append(Data(String(params.isRegular).utf8), withName: "isRegular")
               multiPart.append(Data(String(params.locationIdx).utf8), withName: "locationIdx")
               
               multiPart.append(Data(params.feeType.utf8), withName: "feeType")
               multiPart.append(Data(params.locationDetail.utf8), withName: "locationDetail")
               multiPart.append(Data(params.when.utf8), withName: "when")
               multiPart.append(Data(params.fee.utf8), withName: "fee")
               multiPart.append(Data(params.kakaoChatLink.utf8), withName: "kakaoChatLink")
               if params.tagList.count > 0{
                   for tag in params.tagList{
                       multiPart.append(Data(tag!.utf8), withName: "tagList")
                   }
               }else{
                   multiPart.append(Data("".utf8), withName: "tagList")
               }
               for (idx,image) in params.photos.enumerated() {
                   multiPart.append(image, withName: "photos", fileName: "\(idx).jpg", mimeType: "image/jpeg")

               }
           }, to: "\(Constant.BASE_URL)/app/clubs"
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
                           delegate.successWriteMeed(message: result)

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

