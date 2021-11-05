//
//  RegisterProfileViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/05.
//

import UIKit


class RegisterProfileViewController: UIViewController {
    
    let imagePickerController = UIImagePickerController()
    var whiteViewConstraint:[NSLayoutConstraint] = []
    lazy var datamanager = NickNameDataManager()
    
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
    
    
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var nickNameInfoLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameDivideView: UIView!
    @IBOutlet weak var centerDivideView: UIView!
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
    }
    
    private func configureUI(){
        view.addSubview(submitButton)
        
        //========
        view.addSubview(whiteView)
        
        let l = whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let r = whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let h = whiteView.heightAnchor.constraint(equalToConstant: 88)
        whiteViewConstraint = [l,h,r]
        whiteView.isHidden = true
        //=====
        view.addSubview(nickNameCheckButton)
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nickNameCheckButton.heightAnchor.constraint(equalToConstant: 48),
            nickNameCheckButton.widthAnchor.constraint(equalToConstant: 100),
            nickNameCheckButton.bottomAnchor.constraint(equalTo: nickNameDivideView.bottomAnchor),
            nickNameCheckButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17)
        ])
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        profileImageButton.setTitle("", for: .normal)
        nickNameInfoLabel.textColor = UIColor.dark2
        nickNameDivideView.backgroundColor = .dark2
        centerDivideView.backgroundColor = .primary
        profileTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        introduceView.layer.cornerRadius = 16
        introduceView.layer.borderWidth = 2
        introduceView.layer.borderColor = UIColor.dark2.cgColor
    }
    
    private func configureTargetAction(){
        nickNameCheckButton.addTarget(self, action: #selector(nickNameCheck(_:)), for: .touchUpInside)
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
    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }

    
    @objc private func nickNameCheck(_: UIButton){
        guard let inputNickName = nickNameTextField.text else{return}
        if inputNickName.count > 0 {
            let parameter = NickNameRequest(nickname: inputNickName)
            datamanager.postNickName(parameter, delegate: self)
            print("#function")
        }else{return}
        
        
    }
    
    // MARK: - 키보드 노티
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if nickNameTextField.isEditing {
            return
        }
        
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            whiteViewConstraint.append(whiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: keyboardHeight))
            NSLayoutConstraint.activate(whiteViewConstraint)
            whiteView.isHidden = false
            self.view.frame.origin.y -= keyboardHeight

            }
        }
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if nickNameTextField.isEditing {
            return
        }
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            whiteView.isHidden = true

            self.view.frame.origin.y += keyboardHeight
            }
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
            }
        }


    
}

extension RegisterProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
//            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterProfileViewController {
    
    func failedToRequest(message: String){
        presentAlert(title: message)
        nickNameDivideView.backgroundColor = UIColor.error
        nickNameInfoLabel.textColor = UIColor.error
        nickNameInfoLabel.text = "이미 사용중인 이름입니다."
    }
    func didSuccessPost(message: String){
        presentAlert(title: message)
        nickNameCheckButton.backgroundColor = UIColor.grayDisabled
        nickNameCheckButton.setTitle("사용가능", for: .normal)
        nickNameCheckButton.setTitleColor(UIColor.white, for: .normal)
        nickNameInfoLabel.isHidden = true
    }
}
