//
//  RegisterEmailViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/04.
//

import UIKit

class RegisterEmailViewController : UIViewController {
    
    var email: String?
    var password: String?

    
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
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
    
    
    @IBOutlet weak var emailDivideView: UIView!
    @IBOutlet weak var emailInfoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailClearButton: UIButton!
    
    
    @IBOutlet weak var pwDivideView: UIView!
    @IBOutlet weak var pwClearButton: UIButton!
    @IBOutlet weak var pwInfoLabel: UILabel!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var rePwTextField: UITextField!
    @IBOutlet weak var rePwInfoLabel: UILabel!
    @IBOutlet weak var rePwClearButton: UIButton!
    @IBOutlet weak var rePwDivideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideKeyboardWhenTappedBackground()
    }
    
    
    override func viewDidLayoutSubviews() {
        configureNavi()
    }
    
    @objc func submit(){
        password = pwTextField.text
        email = emailTextField.text
        
        if submitButton.backgroundColor == .primary , password != nil, email != nil{
            guard let RegisterPhoneVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPhoneVC") as? RegisterPhoneViewController else{return}
            RegisterPhoneVC.email = self.email
            RegisterPhoneVC.password = self.password
            self.navigationController?.pushViewController(RegisterPhoneVC, animated: true)
        }
        
    }
    
    @IBAction func rePwCelar(_ sender: Any) {
        rePwTextField.text = ""
    }
    @IBAction func pwClear(_ sender: Any) {
        pwTextField.text = ""
    }
    @IBAction func emailClear(_ sender: Any) {
        emailTextField.text = ""
    }
    private func configureUI(){
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(submit) , for: .touchUpInside)
        
        emailClearButton.setTitle("", for: .normal)
        pwClearButton.setTitle("", for: .normal)
        rePwClearButton.setTitle("", for: .normal)
        
        emailInfoLabel.textColor = .dark2
        pwInfoLabel.text = "숫자, 영문, 특수문자 조합의 8-15 자리의 비밀번호를 입력해주세요."
        pwInfoLabel.textColor = .dark2
        rePwInfoLabel.textColor = .dark2
        rePwInfoLabel.text = "입력하신 비밀번호를 다시 입력해주세요."
        
        rePwDivideView.backgroundColor = .dark2
        emailDivideView.backgroundColor = .dark2
        pwDivideView.backgroundColor = .dark2
        
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        emailTextField.delegate = self
        pwTextField.delegate = self
        rePwTextField.delegate = self
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
    
    private func isValidEmail(str:String) -> Bool {
          let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
          return emailTest.evaluate(with: str)
    }
    private func isValidPassword(str: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        let pwTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return pwTest.evaluate(with: str)
    }
}

extension RegisterEmailViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        var validate = true
        
        if let email = emailTextField.text , email.count > 0 {
            if isValidEmail(str: email){
                emailDivideView.backgroundColor = UIColor.dark2
                emailInfoLabel.text = ""
                validate = true
            }else{
                emailDivideView.backgroundColor = UIColor.error
                emailInfoLabel.textColor = UIColor.error
                emailInfoLabel.text = "유효하지 않은 이메일 계정입니다."
                validate = false
            }
        }
        if let pw = pwTextField.text , pw.count > 0 {
            if isValidPassword(str: pw){
                pwDivideView.backgroundColor = UIColor.dark2
                pwInfoLabel.text = ""
                validate = true
            }else{
                pwDivideView.backgroundColor = UIColor.error
                pwInfoLabel.textColor = UIColor.error
                pwInfoLabel.text = "숫자, 영문, 특수문자 조합의 8-15 자리의 비밀번호를 입력해주세요."
                validate = false
            }
        }
        if let rePw = rePwTextField.text ,rePw.count > 0 {
            if pwDivideView.backgroundColor == UIColor.dark2{
                if rePw == pwTextField.text {
                    rePwDivideView.backgroundColor = UIColor.dark2
                    rePwInfoLabel.text = ""
                    validate = true
                }
                else{
                    rePwDivideView.backgroundColor = UIColor.error
                    rePwInfoLabel.textColor = UIColor.error
                    rePwInfoLabel.text = "비밀번호가 일치하지 않습니다."
                    validate = false
                }
            }
        }
        if validate , rePwDivideView.backgroundColor == pwDivideView.backgroundColor, pwDivideView.backgroundColor  == emailDivideView.backgroundColor{
            submitButton.backgroundColor = UIColor.primary
            submitButton.setTitleColor(UIColor.black, for: .normal)
        }else{
            submitButton.backgroundColor = UIColor.grayDisabled
            submitButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
