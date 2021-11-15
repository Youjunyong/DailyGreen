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
    var communityIdx: Int? // 이전 화면에서 보내줘야됨.
    var clubInfo : [ClubInfo?]?
    
    @IBOutlet weak var tableView: UITableView!
    var childNumber: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()
      
      communityIdx = 2
      meetDataManger.getMeetData(delegate: self, communityIdx: communityIdx!, page: 1)
      
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

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
                cell.upperImageView.load(strUrl: clubInfoObject.clubPhoto)
                cell.profileImageView.load(strUrl: clubInfoObject.profilePhotoUrl)
                cell.titleLabel.text = clubInfoObject.clubName
                cell.locationLabel.text = clubInfoObject.locationDetail
                cell.maxPeopleNum.text = "\(clubInfoObject.nowFollowing)/\(clubInfoObject.maxPeopleNum)명 참가중" 
                cell.bodyLabel.text = clubInfoObject.bio
                cell.dateLabel.text = clubInfoObject.when
                if clubInfoObject.isRegular == 1 {
                    cell.categoryLabel.text = "정기모임"
                }else{
                    cell.categoryLabel.text = "모임"
                }
                
                
            }
        }

        cell.categoryLabel.text = "정기모임"
        
//        if indexPath.row == 2 {
//            cell.devideViewConstraint.constant = 30
//            cell.addHashTag("에코 꼴페미")
//            print(#function)
//        }   // 중앙선을 내리는 과정,
//        태그의 개수를 세서 (태그 높이 * 태그 row) 만큼 더해주고, cell height도 그만큼 높여줘야한다.
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
}


extension MeetingViewController {
    func didSuccessGet(message: String, results: [ClubInfo?]){
        presentAlert(title: message)
        clubInfo = results
        configureTableView()

    }
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
}
