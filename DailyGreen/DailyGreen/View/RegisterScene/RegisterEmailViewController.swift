//
//  RegisterEmailViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/04.
//

import UIKit

class RegisterEmailViewController : UIViewController {
    
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
        guard let RegisterPhoneVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPhoneVC") else{return}
        
        self.navigationController?.pushViewController(RegisterPhoneVC, animated: true)
        
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
