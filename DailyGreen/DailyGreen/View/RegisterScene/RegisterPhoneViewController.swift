//
//  RegisterPhoneViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//

import UIKit

class RegisterPhoneViewController: UIViewController {
    
    lazy var phoneAuthDataManager = PhoneAuthDataManager()
    lazy var checkAuthDataManager = CheckAuthDataManager()
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
    }()
    
    let checkPhoneButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.primary.cgColor
        btn.layer.cornerRadius = 24
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17)
        btn.setTitle("인증하기", for: .normal)
        return btn
    }()
    let checkCodeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.primary.cgColor
        btn.layer.cornerRadius = 24
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17)
        btn.setTitle("확인하기", for: .normal)
        return btn
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("다음", for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17.0)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.grayDisabled
        btn.layer.cornerRadius = 24
        return btn
    }()
    
    @IBOutlet weak var phoneTextFiled: UITextField!
    @IBOutlet weak var phoneDivideView: UIView!
    @IBOutlet weak var phoneInfoLabel: UILabel!
    
    
    @IBOutlet weak var codeDivideView: UIView!
    @IBOutlet weak var codeInfoLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavi()
        hideKeyboardWhenTappedBackground()

    }

    @objc func submit(){
        
        guard let RegisterProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterProfileVC") else{return}
        
        self.navigationController?.pushViewController(RegisterProfileVC, animated: true)
        
    }
    @objc func postAuth(){
        let phoneNumber = phoneTextFiled.text! // 유효성검사 추가해라
        let param = PhoneAuthRequest(phoneNumber: phoneNumber)
        phoneAuthDataManager.postPhoneAuth(param, delegate: self)
    }
    
    @objc func checkAuth(){
        let phoneNumber = phoneTextFiled.text!
        let codeNumber = codeTextField.text! //유효성 검사 추가해라
        let param = CheckAuthRequest(phoneNumber: phoneNumber, verifyCode: codeNumber)
        checkAuthDataManager.checkPhoneAuth(param, delegate: self)
    }
    private func configureUI(){
        view.addSubview(submitButton)
        view.addSubview(checkCodeButton)
        view.addSubview(checkPhoneButton)
        submitButton.addTarget(self, action: #selector(submit) , for: .touchUpInside)
        checkPhoneButton.addTarget(self, action: #selector(postAuth), for: .touchUpInside)
        checkCodeButton.addTarget(self, action: #selector(checkAuth), for: .touchUpInside)
        phoneDivideView.backgroundColor = .dark2
        codeDivideView.backgroundColor = .dark2
        
        
        NSLayoutConstraint.activate([
            checkPhoneButton.heightAnchor.constraint(equalToConstant: 48),
            checkPhoneButton.widthAnchor.constraint(equalToConstant: 100),
            checkPhoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkPhoneButton.bottomAnchor.constraint(equalTo: phoneDivideView.bottomAnchor),
            
            checkCodeButton.heightAnchor.constraint(equalToConstant: 48),
            checkCodeButton.widthAnchor.constraint(equalToConstant: 100),
            checkCodeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkCodeButton.bottomAnchor.constraint(equalTo: codeDivideView.bottomAnchor),
            
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        phoneInfoLabel.textColor = .dark2
        codeInfoLabel.textColor = .dark2
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""

    }
    private func configureNavi(){
        self.title = "회원가입"
        view.addSubview(naviShadowView)
        NSLayoutConstraint.activate([
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension RegisterPhoneViewController {
    func failedPostPhoneAuth(message: String){
        self.presentAlert(title: message)
    }
    
    func successPhoneAuth(message: String) {
        self.presentAlert(title: message)
    }
    func successCheckAuth(message: String) {
        self.presentAlert(title: message)
    }
}
