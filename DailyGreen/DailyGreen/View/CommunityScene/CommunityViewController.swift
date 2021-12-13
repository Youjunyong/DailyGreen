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
    
    
    lazy var dimmingView = DimmingView()
    let naviShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .dark2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "참여 중인 커뮤니티"
        configureUI()
        configureTabelView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        datamanager.getCommunityListDetail(delegate: self)
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
            naviShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func presentDimmingView(){
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alretText = "홈 화면에서 커뮤니티에 참가해주세요"
        view.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        dimmingView.dismissBtn.addTarget(self, action: #selector(removeAlert), for: .touchUpInside)
        
    }
    
    @objc func removeAlert(){
        dimmingView.removeFromSuperview()
    }
    
    @objc func pushPagerTabVC(_ sender: UIButton){

        let storyboard = UIStoryboard(name: "PagerTabbar", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "PagerTabVC") as? PagerTabbarViewController else{return}
        VC.naviTitle = CommunityData.shared.nameArr[sender.tag]
        VC.communityIdx = sender.tag
        self.navigationController?.pushViewController(VC, animated: true)
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
        if 0 < data.idx, data.idx < 9{
            cell.cImageView.image = UIImage(named: CommunityData.shared.imageArr[data.idx])
            cell.pushPagerTabVCButton.tag = data.idx
            cell.pushPagerTabVCButton.setTitle("", for: .normal)
            cell.pushPagerTabVCButton.addTarget(self, action: #selector(pushPagerTabVC(_:)), for: .touchUpInside)
            for (idx,strUrl) in data.profileUrl.enumerated(){

                switch idx {
                case 0:
                    cell.profileImage1.layer.cornerRadius = 10
                    cell.profileImage1.contentMode = .scaleAspectFill
                    cell.profileImage1.load(strUrl: strUrl)
                case 1:
                    cell.profileImage2.load(strUrl: strUrl)
                case 2:
                    cell.profileImage3.load(strUrl: strUrl)
                default:
                    break
                    
                }
                
            }
        }

        return cell
    }
}
extension CommunityViewController {
    
    func failedToRequest(message: String){
//        presentAlert(title: message)
    }
    func didSuccessGet(message: String, dataList: [CommunityList]){
        
        self.dataList = dataList
        if dataList.count == 0 {
            presentDimmingView()
        }
        self.tableView.reloadData()
        
        
    }
}
