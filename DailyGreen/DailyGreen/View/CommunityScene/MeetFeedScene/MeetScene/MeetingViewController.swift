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
    lazy var meetSearchDataManager = MeetSearchDataManager()
    var delegate: PagerTabbarViewController?
    
    var community: String?
    var communityIdx: Int? // 이전 화면에서 보내줘야됨.
    var clubInfo : [ClubInfo?]?
    var childNumber: String = ""
    var didConfigure = false
        
    lazy var emptyLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재 개최중인 모임이 없습니다."
        label.font = UIFont(name: NanumFont.regular, size: 17)
        label.textColor = .grayLongtxt
        return label
    }()
    
    func configureEmptyLabel(type: Int){
        if type == 0{
            view.addSubview(emptyLabel)
            NSLayoutConstraint.activate([
                emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }else{
            view.addSubview(emptyLabel)
            emptyLabel.text = "해당하는 검색결과가 없습니다."
            NSLayoutConstraint.activate([
                emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    
    
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func write(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "WriteScene", bundle: nil)
        guard let writeVC = storyboard.instantiateViewController(withIdentifier: "writeVC") as? WriteStep1ViewController else{return}
        writeVC.modalPresentationStyle = .fullScreen
        writeVC.communityName = self.community
        writeVC.communityIdx = self.communityIdx
        writeVC.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(writeVC, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        configureUI()
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEntireMeetData()
    }
    func getEntireMeetData(){
        if communityIdx != nil {
            meetDataManger.getMeetData(delegate: self, communityIdx: communityIdx!, page: 1)
        }
    }
    
    func searchMeetResult(keyword : String){
        if communityIdx != nil, keyword.count > 0{
            meetSearchDataManager.getMeetSearchData(delegate: self, communityIdx: communityIdx!, page: 1, keyword: keyword)
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
        VC.hidesBottomBarWhenPushed = true

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
                cell.devideViewConstraint.constant = 43
                cell.hashTagView1.isHidden = true
                cell.hashTagView2.isHidden = true
                cell.hashTagView3.isHidden = true
                for (idx, tag) in tagList.enumerated() {
                    let tagName = tag?.tagName ?? ""
                    switch idx{
                    case 0:
                        if tagName.count > 1{
                            cell.hashTagView1.isHidden = false
                        }
                        
                        cell.hashTag1.text = "#\(tagName)"
                        cell.hashTag2.text = ""
                        
                        cell.hashTag3.text = ""
                        
                    case 1:
                        if tagName.count > 1{
                            cell.hashTagView2.isHidden = false
                        }
                        cell.hashTag2.text = "#\(tagName)"
                        cell.hashTag3.text = ""
                        
                    case 2:
                        if tagName.count > 1{
                            cell.hashTagView3.isHidden = false
                        }
                        cell.hashTag3.text = "#\(tagName)"
                        
                    default:
                        break
                    }
                }
                
            }
            else{
                cell.devideViewConstraint.constant = 10
                cell.isHaveHashTag = false
            }
            
            if let photoUrlList = clubInfo[indexPath.row]?.profilePhotoUrlListObj.urlList{
                
//                cell.participateProfileImageView3 = photoUrlList[2]
                for (idx,url) in photoUrlList.enumerated(){
                    guard let strUrl = url?.profilePhotoUrl else{break}

                    switch idx{
                    case 0:
                        cell.participateProfileImageView.load(strUrl: strUrl)
                        cell.participateProfileImageView.contentMode = .scaleAspectFill

                    case 1:
                        cell.participateProfileImageView2.load(strUrl: strUrl)
                        cell.participateProfileImageView.contentMode = .scaleAspectFill

                    case 2:
                        cell.participateProfileImageView3.load(strUrl: strUrl)
                        cell.participateProfileImageView.contentMode = .scaleAspectFill

                    default:
                        break
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 490
    }
}


extension MeetingViewController {
    func didSuccessGet(message: String, results: [ClubInfo?], keyword: String?){
        clubInfo?.removeAll()
        clubInfo = results
        if clubInfo?.count == 0{
            emptyLabel.isHidden = false
            if keyword != nil {
                configureEmptyLabel(type: 1)
            }else{
                configureEmptyLabel(type: 0)
            }
        }else{
            emptyLabel.isHidden = true
        }
        tableView.reloadData()

        
        
    }
    func failedToRequest(message: String){
//        presentAlert(title: message)
    }
}
