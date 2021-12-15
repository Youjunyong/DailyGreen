//
//  ParticipateListViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/14.
//

import UIKit

class ParticipateListViewController: UIViewController {
    
    var participateNames = [String]()
    var participateImages = [String]()
    lazy var nottingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "작성된 댓글이 없습니다!"
        label.font = UIFont(name: NanumFont.regular, size: 17)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        configureTableView()
        configureNottingLabel()
    }
    private func configureNottingLabel(){
        self.view.addSubview(nottingLabel)
        NSLayoutConstraint.activate([
            nottingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nottingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        nottingLabel.isHidden = true
    }
    private func configureTableView(){
        tableView.separatorStyle = .none
        dismissButton.setTitle("", for: .normal)
        titleLabel.font = UIFont(name: NanumFont.bold, size: 24)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ParticipateTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ParticipateCell")
    }
    
}
extension ParticipateListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if participateNames.count == 0{
            nottingLabel.isHidden = false
        }else{
            nottingLabel.isHidden = true
        }
        
        return participateNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipateCell") as? ParticipateTableViewCell else{return UITableViewCell()}
        cell.profileImageView.load(strUrl: self.participateImages[indexPath.row])
        cell.nickNameLabel.text = self.participateNames[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
