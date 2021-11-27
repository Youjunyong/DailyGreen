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
                    "개발자, 디자이너 정보"
                    ]
    
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
        return 3
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
        default:
            break
        }
        
        return indexPath
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}