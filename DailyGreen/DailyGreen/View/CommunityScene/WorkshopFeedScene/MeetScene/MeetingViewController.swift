//
//  MeetingViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//


import UIKit
import XLPagerTabStrip

class MeetingViewController: UIViewController, IndicatorInfoProvider {
    
    lazy var meetDataManger = MeetDataManager()
    
    
    var community: String?
    var communityIdx: Int? // 이전 화면에서 보내줘야됨.
    var clubInfo : [ClubInfo?]?
    var childNumber: String = ""
    
    lazy var emptyLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재 개최중인 모임이 없습니다."
        label.font = UIFont(name: NanumFont.regular, size: 17)
        label.textColor = .grayLongtxt
        return label
    }()
    
    func configureEmptyLabel(){
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func write(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "WriteScene", bundle: nil)
        guard let writeVC = storyboard.instantiateViewController(withIdentifier: "writeVC") as? WriteStep1ViewController else{return}
        writeVC.communityName = self.community
        writeVC.communityIdx = self.communityIdx
        self.navigationController?.pushViewController(writeVC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        configureUI()
        if communityIdx != nil {
            meetDataManger.getMeetData(delegate: self, communityIdx: communityIdx!, page: 1)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func configureUI(){
        writeButton.setTitle("", for: .normal)
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "CoCardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
        
    }
    @objc func detailView(_ sender: UIButton){
        let clubIdx = sender.tag - 100
        
        let storyboard = UIStoryboard(name: "MeetDetailScene", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "meetDetailVC") as? MeetDetailViewController else{return}
        VC.clubIdx = clubIdx
        VC.communityName = self.community
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
}

extension MeetingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CoCardTableViewCell else{return UITableViewCell()}
        
        if let clubInfo = clubInfo{
            if let clubInfoObject = clubInfo[indexPath.row]?.clubInfoObj{
                
                
                
                cell.nickNameLabel.text = clubInfoObject.nickname
                cell.dDayLabel.text = clubInfoObject.Dday
                cell.upperImageView.load(strUrl: clubInfoObject.clubPhoto)
                cell.profileImageView.load(strUrl: clubInfoObject.profilePhotoUrl)
                cell.titleLabel.text = clubInfoObject.clubName
                cell.locationLabel.text = clubInfoObject.locationDetail
                cell.maxPeopleNum.text = "\(clubInfoObject.nowFollowing)/\(clubInfoObject.maxPeopleNum)명 참가중" 
                cell.bodyLabel.text = clubInfoObject.bio
                cell.dateLabel.text = clubInfoObject.when
                cell.participateButton.tag = clubInfoObject.clubIdx + 100
                
                cell.participateButton.addTarget(self, action: #selector(detailView(_:)) , for: .touchUpInside)
                
                if clubInfoObject.isRegular == 0 {
                    cell.categoryLabel.text = "모임"
                }else{
                    cell.categoryLabel.text = "정기모임"
                }
            }
            

            if let tagList = clubInfo[indexPath.row]?.clubTagListObj.tagList{
                cell.isHaveHashTag = true
                cell.devideViewConstraint.constant = 40
                
                for (idx, tag) in tagList.enumerated() {
                    let tagName = tag?.tagName ?? ""
                    
                    switch idx{
                    case 0:
                        cell.hashTag1.text = "#\(tagName)"
                        cell.hashTag2.text = ""
                        cell.hashTag3.text = ""
                        print(idx)
                    case 1:
                        cell.hashTag2.text = "#\(tagName)"
                        cell.hashTag3.text = ""
                        print(idx)
                    case 2:
                        cell.hashTag3.text = "#\(tagName)"
                        print(idx, "#\(tagName)")
                    default:
                        break
                    }
                }
                
            }
            else{
                cell.devideViewConstraint.constant = 10
                cell.isHaveHashTag = false
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
}


extension MeetingViewController {
    func didSuccessGet(message: String, results: [ClubInfo?]){
        
        clubInfo = results
        if clubInfo?.count == 0{
            configureEmptyLabel()
        }else{
            configureTableView()
        }
        

    }
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
}
