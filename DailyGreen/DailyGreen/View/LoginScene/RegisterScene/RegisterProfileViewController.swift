//
//  RegisterProfileViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//

import UIKit
import Alamofire

class RegisterProfileViewController: UIViewController {
    
    let dimmingView = DimmingView()
    var phoneNumber: String?
    var kakaoToken: String?
    var appleToken: String?
    var email: String?
    var password: String?
    
    var isUpdateProfileMode = false
    
    @IBOutlet weak var profileCircleButtonView: UIImageView!
    let imagePickerController = UIImagePickerController()
    var whiteViewConstraint:[NSLayoutConstraint] = []
    
    lazy var datamanager = NickNameDataManager()
    lazy var appleRegisterDataManager = AppleRegisterDataManager()
    lazy var KRegisterDataManager = KakaoRegisterDataManager()
    lazy var emailRegisterDataManger = EmailRegisterDataManager()
    lazy var profileUpdateDataManager = ProfileUpdateDataManager()
    
    let whiteView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nickNameCheckButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("중복확인", for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 24
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.primary.cgColor
        
        return btn
    }()
    
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
    }()

    let submitButtonLabel : UILabel = {
       let label = UILabel()
        label.text = "다음"
        label.textColor = .white
        label.font = UIFont(name: NanumFont.extraBold, size: 17.0)

        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor.grayDisabled
        btn.layer.cornerRadius = 24
        return btn
    }()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var nickNameInfoLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameDivideView: UIView!
    @IBOutlet weak var centerDivideView: UIView!
    @IBOutlet weak var introduceTitleLabel: UILabel!
    @IBOutlet weak var introduceView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBAction func profileSelect(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNavi()
        hideKeyboardWhenTappedBackground()
        textViewPlaceholderSetting()
        configureTargetAction()
        imagePickerController.delegate = self
        if isUpdateProfileMode {
            updateProfileMode()
        }
    }
    

    func updateProfileMode(){
        self.title = "프로필 수정"
        guard let profileUrl = UserDefaults.standard.string(forKey: "profilePhotoUrl") else{return}
        
        profileImageView.load(strUrl: profileUrl)
        profileImageView.isHidden = false
        profileCircleButtonView.isHidden = true
        nickNameTextField.text = UserDefaults.standard.string(forKey: "nickName")
        nickNameTextField.isEnabled = false
        nickNameInfoLabel.text = "닉네임은 변경이 불가합니다."
        nickNameCheckButton.isHidden = true
        textView.text = UserDefaults.standard.string(forKey: "bio")
        submitButton.backgroundColor = .primary
        submitButton.titleLabel?.textColor = UIColor.black
        
    }
    
    private func configureUI(){
        view.addSubview(submitButton)
        view.addSubview(submitButtonLabel)
        view.addSubview(whiteView)
        whiteView.isHidden = true
        let l = whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let r = whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let h = whiteView.heightAnchor.constraint(equalToConstant: 88)
        whiteViewConstraint = [l,h,r]
        whiteView.isHidden = true
        //=====
        view.addSubview(nickNameCheckButton)
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButtonLabel.centerXAnchor.constraint(equalTo: submitButton.centerXAnchor),
            submitButtonLabel.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            nickNameCheckButton.heightAnchor.constraint(equalToConstant: 48),
            nickNameCheckButton.widthAnchor.constraint(equalToConstant: 100),
            nickNameCheckButton.bottomAnchor.constraint(equalTo: nickNameDivideView.bottomAnchor),
            nickNameCheckButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17)
        ])
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        profileImageButton.setTitle("", for: .normal)
        profileImageView.isHidden = true
        profileImageView.layer.cornerRadius = 60
        nickNameInfoLabel.textColor = UIColor.dark2
        nickNameDivideView.backgroundColor = .dark2
        centerDivideView.backgroundColor = .primary
        profileTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        introduceView.layer.cornerRadius = 16
        introduceView.layer.borderWidth = 2
        introduceView.layer.borderColor = UIColor.dark2.cgColor
        introduceTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        introduceTitleLabel.text = "자기소개를 입력해주세요."
    }
    
    private func configureTargetAction(){
        nickNameCheckButton.addTarget(self, action: #selector(nickNameCheck(_:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
    }
    
    private func configureNavi(){
        self.title = "회원가입"
        
        view.addSubview(naviShadowView)
        NSLayoutConstraint.activate([
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func isSubmitReady() -> Bool{
        let nickName = nickNameTextField.text
        let bio = textView.text
        if nickName!.count > 0 , bio!.count > 0 {
            submitButton.backgroundColor = .primary
            submitButtonLabel.textColor = .black
            
            return true
        }else{
            submitButton.backgroundColor = .grayDisabled
            submitButtonLabel.textColor = .white
        }
        return false
    }
    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }

    @objc private func submit(_: UIButton){
        let nickName = nickNameTextField.text!
        let bio = textView.text!
        
        if isUpdateProfileMode {
            let image = profileImageView.image
            guard let data = image?.jpegData(compressionQuality: 0.1) else{return}
            let parameters = [
                "bio" : bio
            ]
            profileUpdateDataManager.patchProfileUpdate(image: data, params: parameters, delegate: self)
            return
        }

        if profileImageView.image != nil , submitButton.backgroundColor == .primary{
            let image = profileImageView.image
            guard let data = image?.jpegData(compressionQuality: 0.1) else{return}
            if kakaoToken != nil{
                let parameters = [
                    "nickname": nickName,
                    "bio" : bio,
                    "accessToken" : kakaoToken
                ]
                UserDefaults.standard.set("kakao", forKey: "way")
                KRegisterDataManager.upload(image: data,  params: parameters, delegate: self)
            }else if appleToken != nil {
                let parameters = [
                    "nickname": nickName,
                    "bio" : bio,
                    "accessToken" : appleToken!
                ]
                UserDefaults.standard.set("apple", forKey: "way")
                appleRegisterDataManager.upload(image: data, params: parameters, delegate: self)

            }
            else if phoneNumber != nil{
                let parameters = [
                    "email": email,
                    "password": password,
                    "phoneNum" : phoneNumber,
                    "nickname": nickName,
                    "bio" : bio
                ]
                UserDefaults.standard.set("email", forKey: "way")

                emailRegisterDataManger.emailRegisterUpload(image: data, params: parameters, delegate: self)

            }
            else{
                //
            }
        }else{
            profileImageView.image = UIImage(named: "defaultImage")
            profileImageView.isHidden = false
            profileCircleButtonView.isHidden = true
            self.presentAlert(title: "이미지를 추가하지 않으면 기본 이미지로 등록됩니다.")
        }
        
        
        
    }
    @objc private func nickNameCheck(_: UIButton){
        guard let inputNickName = nickNameTextField.text else{return}
        if inputNickName.count > 0 {
            let parameter = NickNameRequest(nickname: inputNickName)
            datamanager.postNickName(parameter, delegate: self)
        }else{return}
    }
    
    // MARK: - 키보드 노티
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if nickNameTextField.isEditing {
            return
        }
        
        if self.view.frame.origin.y != 0.0{
            return
        }
        
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            whiteViewConstraint.append(whiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: keyboardHeight))
            NSLayoutConstraint.activate(whiteViewConstraint)
//            whiteView.isHidden = false
            self.view.frame.origin.y -= 100
            
            }
        }
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if nickNameTextField.isEditing {
            return
        }
        if self.view.frame.origin.y == 0.0{
            return
        }
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            whiteView.isHidden = true
            self.view.frame.origin.y += 100
            
            }
        
        _ = isSubmitReady()
        }


    
    func addKeyboardNotifications(){ // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil) }
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    private func presentDimmingView(){
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        if isUpdateProfileMode{
            dimmingView.alretText = "수정이 완료되었습니다."
        }else{
            dimmingView.alretText = "회원가입을 축하합니다."
        }
        
        view.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        dimmingView.dismissBtn.addTarget(self, action: #selector(removeAlert), for: .touchUpInside)
        
    }
    
    @objc func removeAlert(){
        dimmingView.removeFromSuperview()
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]

        if isUpdateProfileMode{
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 4 ], animated: false)
            return
        }
        if kakaoToken != nil {
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 2 ], animated: false)

        }else if appleToken != nil{
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 2 ], animated: false)

        }else{
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - 4 ], animated: false)

        }
    }
    
}

extension RegisterProfileViewController : UITextViewDelegate {
        func textViewPlaceholderSetting() {
            textView.delegate = self // txtvReview가 유저가 선언한 outlet
            textView.text = "자기소개를 자유롭게 입력해주세요.(0/500)."
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: NanumFont.regular, size:15 )
            }
        
        // TextView Place Holder
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        // TextView Place Holder
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "자기소개를 자유롭게 입력해주세요.(0/500)."
                textView.font = UIFont(name: NanumFont.regular, size:15 )
                textView.textColor = UIColor.lightGray
            }else{
                _ = isSubmitReady()
            }
        }


    
}

extension RegisterProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            profileImageView.image = image
            profileCircleButtonView.isHidden = true
            profileImageView.isHidden = false
        }
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterProfileViewController {
    
    func failedToRequest(message: String){
        presentAlert(title: message)
        nickNameDivideView.backgroundColor = UIColor.error
        nickNameInfoLabel.isHidden = false
        nickNameInfoLabel.textColor = UIColor.error
        nickNameInfoLabel.text = "이미 사용중인 이름입니다."
        nickNameCheckButton.backgroundColor = .white
        nickNameCheckButton.setTitle("중복확인", for: .normal)
    }
    func didSuccessPost(message: String){
        presentAlert(title: message)
        nickNameCheckButton.backgroundColor = UIColor.grayDisabled
        nickNameCheckButton.setTitle("사용가능", for: .normal)
        nickNameCheckButton.setTitleColor(UIColor.white, for: .normal)
        nickNameDivideView.backgroundColor = UIColor.dark2
        nickNameInfoLabel.isHidden = true
    }
    func failedToKRegister(message: String){
        presentAlert(title: message)
    }
    func successKRegister(message: String){
        presentDimmingView()
    }
    
}
