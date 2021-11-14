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
import KakaoSDKUser

class LoginViewController: UIViewController{

    lazy var kakaoLoginDataManager = KakaoLoginDataManager()
    
    @IBOutlet weak var testView: UIView!

    @IBOutlet weak var tempLoginButton: UIButton!
    // MARK: - 임시 로그인 기능
    @IBAction func tempLogin(_ sender: Any) {
        
        guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
        self.changeRootViewController(MainTabBarController)
        
    }
    
    // MARK: - 카카오 계정 로그인
    @IBAction func kakaoLogin(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //dosomething
                    let token = oauthToken?.accessToken
                    let storyboard = UIStoryboard(name: "Register", bundle: nil)
                    
                    guard let RegisterProfileVC = storyboard.instantiateViewController(withIdentifier: "RegisterProfileVC") as? RegisterProfileViewController else{return}
                    RegisterProfileVC.kakaoToken = token
                    self.navigationController?.pushViewController(RegisterProfileVC, animated: false)
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
        isHaveKaKaoToken()
        print("LoginVC", #function)
        
    }
    // MARK: - 카카오 토큰 존재 여부
    private func isHaveKaKaoToken(){
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        print("In LoginVC (kakao) : 로그인 필요")
                    }
                    else {
                        //기타 에러
                        print("In LoginVC (kakao) : 기타 에러")
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    print("In LoginVC (kakao) : 토큰 유효성 체크 성공(필요시 토큰 갱신됨")
                    let token  = TokenManager().getToken()?.accessToken
                    print("####토큰?: ", token)
                    
                    let param = KakaoLoginRequest(accessToken:token! )
                    self.kakaoLoginDataManager.postKakaoLogin(param, delegate: self)
                    
                }
            }
        }
        else {
            //로그인 필요
            print("In LoginVC (kakao) : 로그인 필요")
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

    

    


}
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}



extension LoginViewController {
    func successKakaoLogin(message: String){
        presentAlert(title: message)
        let jwt = UserDefaults.standard.string(forKey: "jwt")
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        let profile = UserDefaults.standard.string(forKey: "profilePhotoUrl")
        
        print("로그인 성공", jwt, nickName, profile)
    }
    
    func failedToKakaoLogin(message: String){
        presentAlert(title: message)
    }
}


