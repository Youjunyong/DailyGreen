//
//  SettingViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//

import UIKit

class SettingViewController: UIViewController {
    
    let menuList = ["개인정보 변경",
                    "문의하기, 신고하기",
                    "개인정보 처리방침",
                    "서비스 이용약관"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationItem.title = "설정"
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

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingTableViewCell else{return UITableViewCell()}
        cell.titleLabel.text = menuList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.row{
        case 0:
            guard let PersonalInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "PersonalInfoVC") as? PersonalnfoUpdateViewController else{return indexPath}
            self.navigationController?.pushViewController(PersonalInfoVC, animated: true)
        case 1:
            guard let InquireVC = self.storyboard?.instantiateViewController(withIdentifier: "InquireVC") else{return indexPath}
            self.present(InquireVC, animated: true, completion: nil)
            
        case 2:
            let storyboard = UIStoryboard(name: "PolicyScene", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "PolicyTextVC")
            self.present(VC, animated: true, completion: nil)

        case 3:
            let storyboard = UIStoryboard(name: "PolicyScene", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "ServiceTextVC")
            self.present(VC, animated: true, completion: nil)
            
        default:
            break
        }
        
        return indexPath
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
