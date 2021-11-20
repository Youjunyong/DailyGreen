//
//  EmailRegisterDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/20.
//

import Alamofire

class EmailRegisterDataManager {
    
    func emailRegisterUpload(image: Data?,  params: [String: Any], delegate: RegisterProfileViewController){
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data"
           ]
           AF.upload(multipartFormData: { multiPart in
               for (key, value) in params {
                   if let temp = value as? String {
                       multiPart.append(temp.data(using: .utf8)!, withName: key)
                   }
                   if let temp = value as? Int {
                       multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                   }
                }
               
               if image != nil {
                   multiPart.append(image!, withName: "profilePhoto", fileName: "\(params["nickname"]).jpg", mimeType: "image/jpeg")
               }else{
//                    유저가 프사 안넣으면 nil이라도 넣어서 보내야하는지,,,, ?
//                   그냥 자체적으로 기본사진 넣어서 보내는게 나을듯 .. ?
//                   multiPart.append("", withName: "profilePhoto")
                   print("no image")
               }
           }, to: "\(Constant.BASE_URL)/app/users"
            , headers: headers)
               .uploadProgress(queue: .main, closure: { progress in
                   //Current upload progress of file
                   print("Upload Progress: \(progress.fractionCompleted)")
               })
               .validate()
               .responseDecodable(of: EmailRegisterResponse.self) { response in
                   switch response.result {
                   case .success(let response):
                       // 성공했을 때
                       if response.isSuccess {
                           let result = response.message
                           delegate.successKRegister(message: result)
                           
                       }
                       // 실패했을 때
                       else {
                           switch response.code {
                           case 2007: delegate.failedToKRegister(message: "중복된 닉네임 입니다.")
                           case 2008: delegate.failedToKRegister(message: "닉네임은 9자리 미만으로 입력해주세요.")
                           case 4000: delegate.failedToKRegister(message: "데이터 베이스 에러")
                           default: delegate.failedToKRegister(message: "code : \(response.code)")
                           }
                       }
                   case .failure(let error):
                       print(error.localizedDescription)
                       print(String(describing: error))

                       delegate.failedToKRegister(message: "서버와의 연결이 원활하지 않습니다")
                   }
               }
       }

    
    
    
}
    
