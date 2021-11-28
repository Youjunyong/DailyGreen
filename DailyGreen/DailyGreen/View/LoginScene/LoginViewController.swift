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
    lazy var emailLoginDataManager = EmailLoginDataManager()
    
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "간편 로그인"
        label.font = UIFont(name: NanumFont.bold, size: 17)
        return label
        
    }()
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title4: UILabel!
    
    @IBOutlet weak var emailLoginLabel: UILabel!
    // MARK: - 카카오 계정 로그인
    @IBAction func kakaoLogin(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    let token = oauthToken?.accessToken
                    self.isHaveKakaoToken()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if UserDefaults.standard.string(forKey: "jwt") != nil{
            if UserDefaults.standard.string(forKey: "way") == "email" {
                guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
                self.changeRootViewController(MainTabBarController)
            }else if UserDefaults.standard.string(forKey: "way") == "kakao"{
                guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
                self.changeRootViewController(MainTabBarController)
            }
        }
        setupProviderLoginView()
    }
    
    
    private func configureUI(){
        emailLoginButton.setTitle("", for: .normal)
        emailLoginLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        emailLoginLabel.textColor = .dark2
        view.addSubview(naviShadowView)
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            naviShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            titleLabel.centerXAnchor.constraint(equalTo: naviShadowView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: naviShadowView.topAnchor, constant: -10)
        ])
        
        title1.font = UIFont(name: NanumFont.bold, size: 20)
        title2.font = UIFont(name: NanumFont.bold, size: 20)
        title3.font = UIFont(name: NanumFont.bold, size: 20)
        title4.font = UIFont(name: NanumFont.bold, size: 20)
        
        
        let attributedStr = NSMutableAttributedString(string: title2.text!)
        attributedStr.addAttribute(.foregroundColor , value: UIColor.dark2, range:(title2.text! as NSString).range(of: "그린이") )
        title2.attributedText = attributedStr
        
        let attributedStr2 = NSMutableAttributedString(string: title4.text!)
        attributedStr2.addAttribute(.foregroundColor , value: UIColor.dark2, range:(title4.text! as NSString).range(of: "그린") )
        title4.attributedText = attributedStr2
        
        
    }
    // MARK: - 카카오 토큰 존재 여부
    private func isHaveKakaoToken(){
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        print("In LoginVC (kakao) : 로그인 필요")
                    }
//                    else {
//                        //기타 에러
//                        print("In LoginVC (kakao) : 기타 에러")
//                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    print("In LoginVC (kakao) : 토큰 유효성 체크 성공(필요시 토큰 갱신됨")
                    let token  = TokenManager().getToken()?.accessToken
                    let param = KakaoLoginRequest(accessToken:token!)
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
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        switch authorization.credential { case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            if let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authString = String(data: authorizationCode, encoding: .utf8),
                let tokenString = String(data: identityToken, encoding: .utf8){
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authString: \(authString)")
                print("tokenString: \(tokenString)")
            }
                print("useridentifier: \(userIdentifier)")
                
                
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            default: break
            
        }
    }
}
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
extension LoginViewController {
    
    
    
    func successKakaoLogin(message: String){
        guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
        self.changeRootViewController(MainTabBarController)
    }
    

    
    func failedToKakaoLogin(message: String){
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let token  = TokenManager().getToken()?.accessToken
        guard let RegisterProfileVC = storyboard.instantiateViewController(withIdentifier: "RegisterProfileVC") as? RegisterProfileViewController else{return}
        RegisterProfileVC.kakaoToken = token
        self.navigationController?.pushViewController(RegisterProfileVC, animated: false)
    }
}


