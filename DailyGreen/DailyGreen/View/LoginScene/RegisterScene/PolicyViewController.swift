//
//  PolicyViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/29.
//

import UIKit

class PolicyViewController: UIViewController{
    
    var entire = false
    var pri = false
    var ser = false
    var presentingLoginView: LoginViewController?
    var presentingEmailLoginView: EmailLoginViewController?
    var type = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBodyLabel: UILabel!
    @IBOutlet weak var entireImageView: UIImageView!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var privateImageView: UIImageView!
    @IBOutlet weak var entireCheckLabel: UILabel!
    
    @IBOutlet weak var divideView1: UIView!
    @IBOutlet weak var divideView2: UIView!
    @IBOutlet weak var divideView3: UIView!
    
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var privateLabel: UILabel!
    @IBOutlet weak var privateButton: UIButton!
    @IBOutlet weak var serviceButton: UIButton!

    @IBOutlet weak var entireButton: UIButton!
    @IBOutlet weak var submitImageView: UIImageView!
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    @IBAction func entire(_ sender: Any) {

        if entire{
            pri = false
            ser = false
            entire = false
            entireImageView.image = UIImage(named: "write")
            serviceImageView.image = UIImage(named: "write")
            privateImageView.image = UIImage(named: "write")

        }else{
            pri = true
            ser = true
            entire = true
            entireImageView.image = UIImage(named: "writeFill")
            serviceImageView.image = UIImage(named: "writeFill")
            privateImageView.image = UIImage(named: "writeFill")

        }
        _ = check()
    }
    @IBAction func submit(_ sender: Any) {
        
        
        if check(){
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            if type == "kakao"{
                presentingLoginView?.kakaoRegister()
            }else if type == "apple"{
                presentingLoginView?.appleRegister()
            }else{
                presentingEmailLoginView?.emailRegister()
            }
        }
    }
    
    
    @IBOutlet weak var serviceBtn: UIButton!
    
    @IBOutlet weak var privateBtn: UIButton!
    
    @IBAction func dismissButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func serviceButton(_ sender: Any) {
        
        if ser{
            ser = false
            entire = false
            entireImageView.image = UIImage(named: "write")
            serviceImageView.image = UIImage(named: "write")
        }else{
            ser = true
            serviceImageView.image = UIImage(named: "writeFill")
            if pri, ser{
                entire = true
                entireImageView.image = UIImage(named: "writeFill")
            }
        }
        _ = check()
    }
    
    @IBAction func privateButton(_ sender: Any) {

        if pri{
            pri = false
            entire = false
            entireImageView.image = UIImage(named: "write")
            privateImageView.image = UIImage(named: "write")
        }else{
            pri = true
            privateImageView.image = UIImage(named: "writeFill")
            if pri, ser{
                entire = true
                entireImageView.image = UIImage(named: "writeFill")
            }
        }
        _ = check()
    }
    
    
    @IBAction func presentPrivatePolicy(_ sender: Any) {

        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "PolicyTextVC") else{return}
        
        self.present(VC, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func presentServicePolicy(_ sender: Any) {
    }
    
    
    private func check() -> Bool{
        if pri, entire, ser{
            submitImageView.image = UIImage(named: "doneButtonTrue")
            return true
        }else{
            submitImageView.image = UIImage(named: "doneButtonFalse")
            return false
        }
    }
    
    private func configureUI(){
        dismissBtn.setTitle("", for: .normal)
        serviceBtn.setTitle("", for:.normal)
        privateBtn.setTitle("", for: .normal)
        entireButton.setTitle("", for: .normal)
        submitButton.setTitle("", for: .normal)
        serviceButton.setTitle("", for: .normal)
        privateButton.setTitle("", for: .normal)
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        titleLabel.text = "약관동의"
        titleBodyLabel.text = "일상그린에서 보다 더 나은 서비스를 제공받기 위해서는 이용약관 동의가 꼭 필요합니다."
        
        entireCheckLabel.text = "전체동의"
        entireCheckLabel.font = UIFont(name: NanumFont.bold, size: 17)
        serviceLabel.text = "서비스 이용약관 (필수)"
        serviceLabel.font =  UIFont(name: NanumFont.regular, size: 17)
        privateLabel.text = "개인정보 취급방침 (필수)"
        privateLabel.font =  UIFont(name: NanumFont.regular, size: 17)
        
        divideView1.backgroundColor = .dark2
        divideView2.backgroundColor = .dark2
        divideView3.backgroundColor = .dark2
    }
    
}
