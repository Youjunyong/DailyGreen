//
//  MyPageViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit

class MyPageViewController: UIViewController{
    
    
    @IBAction func settingTouched(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SettingScene", bundle: nil)
        let SettingVC = storyboard.instantiateViewController(withIdentifier: "SettingVC")
        self.navigationController?.pushViewController(SettingVC, animated: true)

    }
    @IBOutlet weak var settingTouched: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        title = "나의 계정"
    }
}
