//
//  ProfileUpdateDataManager.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/03.
//

import Alamofire

class ProfileUpdateDataManager {
    
    func patchProfileUpdate(image: Data?,  params: [String: Any], delegate: RegisterProfileViewController){
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data",
               "X-ACCESS-TOKEN": Constant.shared.JWTTOKEN
           ]
           AF.upload(multipartFormData: { multiPart in
               print(Constant.shared.JWTTOKEN)
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
                   print("no image")
               }
           }, to: "\(Constant.BASE_URL)/app/users"
                     , method: .patch
            , headers: headers)
               .uploadProgress(queue: .main, closure: { progress in
               })
               .validate()
               .responseDecodable(of: UpdateProfileResponse.self) { response in
                   switch response.result {
                   case .success(let response):
                       if response.isSuccess {
                           let result = response.message
                           guard let newUrl = response.result?.profilePhotoUrl else{break}
                           UserDefaults.standard.set(newUrl, forKey: "profilePhotoUrl")
                           delegate.successKRegister(message: result)
                       }
                       else {
                           switch response.code {
                           case 2007: delegate.failedToKRegister(message: "중복된 닉네임 입니다.")
                           case 2008: delegate.failedToKRegister(message: "닉네임은 9자리 미만으로 입력해주세요.")
                           case 4000: delegate.failedToKRegister(message: "데이터 베이스 에러")
                           default: delegate.failedToKRegister(message: "code : \(response.message)")
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





