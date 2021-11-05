//
//  LoginViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit
import AuthenticationServices
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewController: UIViewController{

    @IBOutlet weak var testView: UIView!

    // MARK: - 임시 로그인 기능
    @IBAction func tempLogin(_ sender: Any) {
        
        guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
        self.changeRootViewController(MainTabBarController)
        
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    
                    _ = oauthToken
                }
            }
        }
    }
    
    func setupProviderLoginView() {
        let appleButton = ASAuthorizationAppleIDButton(type:.signIn , style: .black )
        appleButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.testView.addSubview(appleButton)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.leadingAnchor.constraint(equalTo: testView.leadingAnchor).isActive = true
        appleButton.trailingAnchor.constraint(equalTo: testView.trailingAnchor).isActive = true
        appleButton.topAnchor.constraint(equalTo: testView.topAnchor).isActive = true
        appleButton.bottomAnchor.constraint(equalTo: testView.bottomAnchor).isActive = true
        
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
        
    }
    
//    func onKakaoLoginByAppTouched(_ sender: Any) {
//     // 카카오톡 설치 여부 확인
//        AuthApi.isKakaoTalkLoginUrl(<#T##url: URL##URL#>)
//        
//      if (AuthApi.isKakaoTalkLoginAvailable()) {
//        // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
//        AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//            if let error = error {
//                // 예외 처리 (로그인 취소 등)
//                print(error)
//            }
//            else {
//                print("loginWithKakaoTalk() success.")
//               // do something
//                _ = oauthToken
//               // 어세스토큰
//               let accessToken = oauthToken?.accessToken
//            }
//        }
//      }
//    }

}
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}


