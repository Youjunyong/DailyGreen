//
//  EmailLoginViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    lazy var emailLoginDataManager = EmailLoginDataManager()
    
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("완료", for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17.0)
        btn.backgroundColor = UIColor.primary
        btn.layer.cornerRadius = 24
        
        return btn
    }()
    
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
    }()
    
//    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var findEmailLabel: UILabel!
    @IBOutlet weak var findPwButton: UIButton!
    @IBOutlet weak var findEmailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailDivideView: UIView!
    @IBOutlet weak var pwDivideView: UIView!
    @IBOutlet weak var pwDeleteButton: UIButton!
    @IBOutlet weak var emailDeleteButton: UIButton!
    @IBOutlet weak var findPwLabel: UILabel!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var footerDivideView: UIView!
    @IBOutlet weak var centerDivideView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func register(_ sender: Any) {
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
    
    @IBAction func findEmail(_ sender: Any) {
    }
    
    @IBAction func findPassWord(_ sender: Any) {
    }
    override func viewDidLoad() {
        configureUI()
        configureNavi()
        
    }
    private func configureNavi(){
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    @objc func submitEmailLogin(_ sender: UIButton){
        let email = emailTextField.text ?? ""
        let password = pwTextField.text ?? ""
        
        if email.count > 3, password.count > 8 {
            let params = EmailLoginRequest(email: email, password: password)
            emailLoginDataManager.postEmailLogin(params, delegate: self)
        } //나중에 유효성검사다시
        
    }
    private func configureUI(){

        self.hideKeyboardWhenTappedBackground()
        view.addSubview(submitButton)
        view.addSubview(naviShadowView)
        submitButton.addTarget(self, action: #selector(submitEmailLogin(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([

            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            naviShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        findEmailButton.setTitle("", for: .normal)
        findPwButton.setTitle("", for: .normal)
        
        findEmailLabel.text = "가입 이메일 계정 찾기"
        findEmailLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        findEmailLabel.textColor = UIColor.dark2

        findPwLabel.text = "비밀번호 찾기"
        findPwLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        findPwLabel.textColor = UIColor.dark2
        
        
        pwDeleteButton.setTitle("", for: .normal)
        emailDeleteButton.setTitle("", for: .normal)
        emailDivideView.backgroundColor = .dark2
        pwDivideView.backgroundColor = .dark2
        
        footerDivideView.backgroundColor = .dark1
        centerDivideView.backgroundColor = .dark2
        
        registerLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        registerLabel.text = "회원가입"
        registerButton.setTitle("", for: .normal)
        registerLabel.textColor = UIColor.dark2
    }
    
   
    
}

extension EmailLoginViewController{
    func successEmailLogin(message: String){
//        UserDefaults.standard.string(forKey: "jwt")
//        UserDefaults.standard.string(forKey: "nickName")
//        UserDefaults.standard.string(forKey: "profilePhotoUrl")
        presentAlert(title: message)

        guard let MainTabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{return}
        self.changeRootViewController(MainTabBarController)
    }
    
    func failedToEmailLogin(message: String){
        presentAlert(title: message)
    }
    
}
