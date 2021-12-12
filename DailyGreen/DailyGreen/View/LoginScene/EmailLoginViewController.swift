//
//  EmailLoginViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    lazy var emailLoginDataManager = EmailLoginDataManager()
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
    }()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailDivideView: UIView!
    @IBOutlet weak var pwDivideView: UIView!
    @IBOutlet weak var pwDeleteButton: UIButton!
    @IBOutlet weak var emailDeleteButton: UIButton!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var registerUnderView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func register(_ sender: Any) {
        modalPresent(type: "email")
    }
    func emailRegister(){
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let RegisterNaviVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        self.navigationController?.pushViewController(RegisterNaviVC, animated: true)
    }
    @IBAction func emailClear(_ sender: Any) {
        emailTextField.text = ""
    }
    
    @IBAction func pwClear(_ sender: Any) {
        pwTextField.text = ""
    }
    
    private func modalPresent(type: String){
        let storyboard = UIStoryboard(name: "PolicyScene", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "PolicyVC") as? PolicyViewController else{return}
        VC.presentingEmailLoginView = self
        VC.type = type
        self.present(VC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        configureUI()
        configureNavi()
    }
    private func configureNavi(){
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    
    @IBAction func submitEmailLogin(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = pwTextField.text ?? ""
        
        if email.count > 3, password.count > 8 {
            let params = EmailLoginRequest(email: email, password: password)
            emailLoginDataManager.postEmailLogin(params, delegate: self)
        }
    }
    private func configureUI(){
        loginButton.setTitle("", for: .normal)
        pwTextField.textContentType = .oneTimeCode
        registerUnderView.backgroundColor = .dark2
        loginButtonLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        self.hideKeyboardWhenTappedBackground()
        view.addSubview(naviShadowView)
        NSLayoutConstraint.activate([
            naviShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        pwDeleteButton.setTitle("", for: .normal)
        emailDeleteButton.setTitle("", for: .normal)
        emailDivideView.backgroundColor = .dark2
        pwDivideView.backgroundColor = .dark2
        registerLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        registerLabel.text = "이메일로 회원가입"
        registerButton.setTitle("", for: .normal)
        registerLabel.textColor = UIColor.dark2
    }
}

extension EmailLoginViewController{
    func successEmailLogin(message: String){
//        presentAlert(title: message)
        guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
        self.changeRootViewController(MainTabBarController)
    }
    func failedToEmailLogin(message: String){
        presentAlert(title: message)
    }
}
