//
//  PersonalnfoUpdateViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit

class PersonalnfoUpdateViewController : UIViewController{
    
    let menuList = ["프로필 변경",
                    "로그아웃 혹은 회원탈퇴"
                    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationItem.title = "개인정보 변경"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension PersonalnfoUpdateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingTableViewCell else{return UITableViewCell()}
        cell.titleLabel.text = menuList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Register", bundle: nil)
            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "RegisterProfileVC") as? RegisterProfileViewController else{break}
            profileVC.isUpdateProfileMode = true
            profileVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(profileVC, animated: true)
        case 1:
            guard let LogoutSignOutVC = self.storyboard?.instantiateViewController(withIdentifier: "LogoutSIgnOutVC") as? LogoutSignOutViewController else{return indexPath}
            self.navigationController?.pushViewController( LogoutSignOutVC, animated: true)
        default:
            break
        }
        return indexPath
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
