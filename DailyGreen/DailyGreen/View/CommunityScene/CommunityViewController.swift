//
//  CommunityViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/08.
//

import UIKit

class CommunityViewController: UIViewController {
    var dataList: [CommunityList]? = nil
    lazy var datamanager = CommunityListDataManager()
    
    let naviShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .dark2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        datamanager.getCommunityListDetail(delegate: self)
        title = "참여 중인 커뮤니티"
        configureUI()
        configureTabelView()
    }

    private func configureTabelView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CommunityTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
    }
    
    
    private func configureUI() {
        view.addSubview(naviShadowView)
        
        NSLayoutConstraint.activate([
            naviShadowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CommunityTableViewCell else{return UITableViewCell()}

        
        guard let data = dataList?[indexPath.row] else {return cell }
        
        cell.titleLabel.text = data.name
        cell.numOfFollowerLabel.text = "\(data.followers)"
        
        cell.cImageView.image = UIImage(named: Constant.imageArr[data.idx + 1])
        
        for (idx,strUrl) in data.profileUrl.enumerated(){
            let url = URL(string: strUrl)
            var image : UIImage?
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    image = UIImage(data: data!)
                    switch idx {
                        case 0:
                            cell.profileImage1.image = image
                        case 1:
                            cell.profileImage2.image = image
                        case 2:
                            cell.profileImage3.image = image
                        default:
                            break
                    }
                }
            }
            
        }
        return cell
    }
}
extension CommunityViewController {
    
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
    func didSuccessGet(message: String, dataList: [CommunityList]){
        
        self.dataList = dataList
        self.tableView.reloadData()
        presentAlert(title: message)
        
    }
}
