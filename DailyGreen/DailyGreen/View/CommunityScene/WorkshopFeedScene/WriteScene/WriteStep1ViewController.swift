//
//  WriteStep1ViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/16.
//

import UIKit

class WriteStep1ViewController: UIViewController {
    
    var communityName: String?
    var communityIdx: Int?
    var selected: String?
    
    @IBOutlet weak var communityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleUnderView: UIView!
    
    @IBOutlet weak var secTitleLabel: UILabel!
    @IBOutlet weak var secTitleUnderView: UIView!
    
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var feedSubLabel: UILabel!
    @IBOutlet weak var meetLabel: UILabel!
    
    @IBOutlet weak var meetSubLabel: UILabel!
    
    @IBOutlet weak var rMeetLabel: UILabel!
    
    @IBOutlet weak var rMeetSubLabel: UILabel!
    
    @IBOutlet weak var workshopLabel: UILabel!

    @IBOutlet weak var workshopSubLabel: UILabel!
    @IBOutlet weak var divideTitleLabel: UILabel!
    
    @IBOutlet weak var thirdTitleLabel: UILabel!
    @IBOutlet weak var thirdTitleUnderView: UIView!
    
    @IBOutlet weak var radioButton1: UIButton!
    @IBOutlet weak var radioButtonView1: UIImageView!
    
    
    @IBOutlet weak var radioButton2: UIButton!
    @IBOutlet weak var radioButtonView2: UIImageView!
    
    @IBOutlet weak var radioButton3: UIButton!
    @IBOutlet weak var radioButtonView3: UIImageView!
    
    @IBOutlet weak var radioButton4: UIButton!
    @IBOutlet weak var radioButtonView4: UIImageView!
    
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButtonView: UIView!
    
    
    
    @IBAction func radioButton1(_ sender: Any) {
        selectedCheck(num : 1)
    }
    
    @IBAction func radioButton2(_ sender: Any) {
        selectedCheck(num : 2)
    }
    
    @IBAction func radioButton3(_ sender: Any) {
        selectedCheck(num : 3)
    }
    
    @IBAction func radioButton4(_ sender: Any) {
        selectedCheck(num : 4)
    }
    
    
    
    @IBAction func submit(_ sender: Any) {
        if submitButtonView.backgroundColor == .grayDisabled {return}
        switch selected {
        case "자유글":
            guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "WriteFeedVC") as? WriteFeedViewController else{return}
            VC.communityName = self.communityName
            VC.communityIdx = self.communityIdx
            self.navigationController?.pushViewController(VC, animated: true)
        case "모임":
            guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "WriteMeetVC") as? WriteMeetViewController else{return}
            VC.communityName = self.communityName
            VC.communityIdx = self.communityIdx
            VC.titleName = "모임"
            self.navigationController?.pushViewController(VC, animated: true)
            
        default:
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.title = "\(communityName ?? "") 글쓰기"
        configureUI()
        configureNaviShadow()
    }
    
    private func configureUI(){
        communityLabel.text = self.communityName
        communityLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        titleLabel.font = UIFont(name: NanumFont.regular, size: 15)
        feedLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        meetLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        rMeetLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        workshopLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        
        
        feedSubLabel.font = UIFont(name: NanumFont.regular, size: 13)
        meetSubLabel.font = UIFont(name: NanumFont.regular, size: 13)
        rMeetSubLabel.font = UIFont(name: NanumFont.regular, size: 13)
        workshopSubLabel.font = UIFont(name: NanumFont.regular, size: 13)
        
        divideTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        divideTitleLabel.textColor = UIColor.dark2
        secTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        thirdTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        
        titleUnderView.backgroundColor = UIColor.dark2
        secTitleUnderView.backgroundColor = UIColor.primary
        thirdTitleUnderView.backgroundColor = UIColor.primary
        
        radioButton1.setTitle("", for: .normal)
        radioButton2.setTitle("", for: .normal)
        radioButton3.setTitle("", for: .normal)
        radioButton4.setTitle("", for: .normal)
        radioButtonView1.image = UIImage(named: "write")
        radioButtonView2.image = UIImage(named: "write")
        radioButtonView3.image = UIImage(named: "write")
        radioButtonView4.image = UIImage(named: "write")
        
        submitButton.setTitle("완료", for: .normal)
        
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.textColor = .white
        submitButton.titleLabel!.font = UIFont(name: NanumFont.extraBold, size: 17)
        
        submitButtonView.layer.cornerRadius = 24
        submitButtonView.backgroundColor = .grayDisabled

    }
    

    private func configureNaviShadow(){
        let naviShadowView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .dark1
            return view
        }()
        view.addSubview(naviShadowView)
        NSLayoutConstraint.activate([
            naviShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    private func selectedCheck(num : Int){
        submitButton.titleLabel?.textColor = .black
        submitButtonView.backgroundColor = .primary
        switch num{
        case 1:
            radioButtonView1.image = UIImage(named: "writeFill")
            radioButtonView2.image = UIImage(named: "write")
            radioButtonView3.image = UIImage(named: "write")
            radioButtonView4.image = UIImage(named: "write")
            selected = "자유글"

        case 2:
            radioButtonView1.image = UIImage(named: "write")
            radioButtonView2.image = UIImage(named: "writeFill")
            radioButtonView3.image = UIImage(named: "write")
            radioButtonView4.image = UIImage(named: "write")
            selected = "모임"
        case 3:
            radioButtonView1.image = UIImage(named: "write")
            radioButtonView2.image = UIImage(named: "write")
            radioButtonView3.image = UIImage(named: "writeFill")
            radioButtonView4.image = UIImage(named: "write")
            selected = "정기모임"
        case 4:
            radioButtonView1.image = UIImage(named: "write")
            radioButtonView2.image = UIImage(named: "write")
            radioButtonView3.image = UIImage(named: "write")
            radioButtonView4.image = UIImage(named: "writeFill")
            selected = "워크샵"
        default:
            return
        }
        
    }
    
}




