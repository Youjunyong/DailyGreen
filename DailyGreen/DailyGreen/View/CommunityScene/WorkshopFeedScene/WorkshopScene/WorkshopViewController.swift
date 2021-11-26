
//  WorkshopViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit
import XLPagerTabStrip
class WorkshopViewController: UIViewController,IndicatorInfoProvider{

    lazy var workshopDataManager = WorkshopDataManager()
    var childNumber: String = ""
    var community: String?
    var communityIdx: Int?
    var workshopInfo: [WorkshopInfo?]?
    
    lazy var emptyLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재 개최중인 워크샵이 없습니다."
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
    
    @IBOutlet weak var writeBtn: UIButton!
    @IBAction func writeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WriteScene", bundle: nil)
        guard let writeVC = storyboard.instantiateViewController(withIdentifier: "writeVC") as? WriteStep1ViewController else{return}
        writeVC.communityName = self.community
        writeVC.communityIdx = self.communityIdx
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    
  override func viewDidLoad() {

      super.viewDidLoad()
      
      tableView.separatorStyle = .none
      writeBtn.setTitle("", for: .normal)
      if communityIdx != nil{
          workshopDataManager.getWorkshopData(delegate: self, communityIdx: communityIdx!, page: 1)
      }
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
extension WorkshopViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workshopInfo!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CoCardTableViewCell else{return UITableViewCell()}
        if let workshopInfo = workshopInfo{
            if let workshopInfoObject = workshopInfo[indexPath.row]?.workshopInfoObj{
                cell.nickNameLabel.text = workshopInfoObject.nickname
                cell.dDayLabel.text = workshopInfoObject.Dday
                cell.upperImageView.load(strUrl: workshopInfoObject.workshopPhoto)
                print("######", workshopInfoObject.workshopPhoto)
                cell.profileImageView.load(strUrl: workshopInfoObject.profilePhotoUrl)
                cell.titleLabel.text = workshopInfoObject.workshopName
                cell.locationLabel.text = workshopInfoObject.locationDetail
                cell.maxPeopleNum.text = "\(workshopInfoObject.nowFollowing)/\(workshopInfoObject.maxPeopleNum)명 참가중"
                cell.bodyLabel.text = workshopInfoObject.bio
                cell.dateLabel.text = workshopInfoObject.when
                
                if let tagList = workshopInfo[indexPath.row]?.workshopTagListObj?.tagList{
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
        }
        cell.categoryLabel.text = "워크샵"
        


        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
}


extension WorkshopViewController {
    func didSuccessGet(message: String, results: [WorkshopInfo?]){
        presentAlert(title: message)
        workshopInfo = results
        if workshopInfo?.count == 0{
            configureEmptyLabel()
        }else{
            configureTableView()
        }
    }
    
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
}
