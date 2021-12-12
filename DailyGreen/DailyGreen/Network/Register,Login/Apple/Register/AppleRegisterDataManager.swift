//
//  AppleRegisterDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/29.
//

import Alamofire

class AppleRegisterDataManager {
    
    func upload(image: Data?,  params: [String: Any], delegate: RegisterProfileViewController){
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
                   multiPart.append(image!, withName: "profilePhoto", fileName: "\(params["nickname"]).png", mimeType: "image/jpeg")
               }
                   
           }, to: "\(Constant.BASE_URL)/app/users/apple"
            , headers: headers)
               .uploadProgress(queue: .main, closure: { progress in
                   //Current upload progress of file
                   print("Upload Progress: \(progress.fractionCompleted)")
               })
               .validate()
               .responseDecodable(of: AppleRegisterResponse.self) { response in
                   switch response.result {
                   case .success(let response):
                       // 성공했을 때
                       if response.isSuccess {
                           
                           let result = response.result
                           guard let jwt = result?.jwt else{return}
                           UserDefaults.standard.set(jwt, forKey: "jwt")

                           guard let nickName = result?.nickname else{return}
                           UserDefaults.standard.set(nickName, forKey: "nickName")

                           guard let profilePhotoUrl = result?.profilePhotoUrl else{return}
                           UserDefaults.standard.set(profilePhotoUrl, forKey: "profilePhotoUrl")

                           guard let userIdx = result?.userIdx else{return}
                           UserDefaults.standard.set(userIdx, forKey: "userIdx")
                           
                           UserDefaults.standard.set("apple", forKey:"way")
                           delegate.successKRegister(message: response.message)
                       }
                       // 실패했을 때
                       else {
                           switch response.code {
                           case 2007: delegate.failedToKRegister(message: "중복된 닉네임 입니다.")
                           default: delegate.failedToKRegister(message: response.message)
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
    
