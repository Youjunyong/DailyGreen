//
//  ReportViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/05.
//

import UIKit

class ReportViewController: UIViewController {
    
    let dimmingView = DimmingView()
    lazy var reportDataManager = ReportDataManager()
    var idx: Int?
    var sort: String?
    var checkedNum = 0
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("신고하기", for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17.0)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.grayDisabled
        btn.layer.cornerRadius = 24
        return btn
    }()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var divideView1: UIView!
    @IBOutlet weak var divideView2: UIView!
    @IBOutlet weak var divideView3: UIView!
    @IBOutlet weak var divideView4: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var textFrameView: UIView!
    @IBOutlet weak var btnImageView1: UIImageView!
    @IBOutlet weak var btnImageView2: UIImageView!
    @IBOutlet weak var btnImageView3: UIImageView!
    @IBOutlet weak var btnImageView4: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBAction func check1(_ sender: Any) {
        checkedNum = 1
        check()
    }
    @IBAction func check2(_ sender: Any) {
        checkedNum = 2
        check()
    }
    @IBAction func check3(_ sender: Any) {
        checkedNum = 3
        check()
    }
    @IBAction func check4(_ sender: Any) {
        checkedNum = 4
        check()
    }
    private func check(){
        btnImageView1.image = UIImage(named: "write")
        btnImageView2.image = UIImage(named: "write")
        btnImageView3.image = UIImage(named: "write")
        btnImageView4.image = UIImage(named: "write")
        submitButton.backgroundColor = .primary
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.titleLabel?.textColor = UIColor.black

        switch checkedNum{
        case 1:
            btnImageView1.image = UIImage(named: "writeFill")
            textView.isHidden = true
            textFrameView.isHidden = true
        case 2:
            btnImageView2.image = UIImage(named: "writeFill")
            textView.isHidden = true
            textFrameView.isHidden = true
        case 3:
            btnImageView3.image = UIImage(named: "writeFill")
            textView.isHidden = true
            textFrameView.isHidden = true
        case 4:
            btnImageView4.image = UIImage(named: "writeFill")
            textView.isHidden = false
            textFrameView.isHidden = false
        default:
            return
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedBackground()
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        label1.font = UIFont(name: NanumFont.regular, size: 16)
        label2.font = UIFont(name: NanumFont.regular, size: 16)
        label3.font = UIFont(name: NanumFont.regular, size: 16)
        label4.font = UIFont(name: NanumFont.regular, size: 16)
        
        submitButton.addTarget(self, action: #selector(submit(_:)), for: .touchUpInside)
        
        btn1.setTitle("", for: .normal)
        btn2.setTitle("", for: .normal)
        btn3.setTitle("", for: .normal)
        btn4.setTitle("", for: .normal)
        
        textFrameView.layer.borderColor = UIColor.dark2.cgColor
        textFrameView.layer.borderWidth = 2
        textFrameView.layer.cornerRadius = 16
        dismissButton.setTitle("", for: .normal)
        
        divideView1.backgroundColor = .dark2
        divideView2.backgroundColor = .dark2
        divideView3.backgroundColor = .dark2
        divideView4.backgroundColor = .dark2
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.topAnchor.constraint(equalTo: textFrameView.bottomAnchor, constant: 40)
        ])
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @objc func submit(_ sender: UIButton){
        var content = textView.text!
        if content.count == 0 {
            content = "신고 사유 없음"
        }
        let params = ReportRequest(idx: self.idx!, sort: self.sort!, content: content)
        reportDataManager.reportPost(params, delegate: self)
    }
    @objc func removeAlert(){
        dimmingView.removeFromSuperview()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    private func presentDimmingView(){
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alretText = "신고가 완료되었습니다."
        view.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        dimmingView.dismissBtn.addTarget(self, action: #selector(removeAlert), for: .touchUpInside)
    }
}
extension ReportViewController : UITextViewDelegate {
    func textViewPlaceholderSetting() {
        textView.delegate = self
        textView.text = "신고이유를 적어주세요.(0/500)."
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: NanumFont.regular, size:15 )
        }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "신고이유를 적어주세요.(0/500)."
            textView.font = UIFont(name: NanumFont.regular, size:15 )
            textView.textColor = UIColor.lightGray
        }else{
        }
    }
}


extension ReportViewController{
    func didSuccessReport(message: String ){
        presentDimmingView()
    }
    func failedToRequest(message: String){
//        self.presentAlert(title: message)
        
    }
}
