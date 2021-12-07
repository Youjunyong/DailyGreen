//
//  SettingInquireViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/05.
//

import UIKit

class SettingInquireViewController: UIViewController{
    
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.setTitle("", for: .normal)
        underView.backgroundColor = .dark2
        emailLabel.font = UIFont(name: NanumFont.regular, size: 17)
        titleLabel.font = UIFont(name: NanumFont.bold , size: 17)
    }
    
}
