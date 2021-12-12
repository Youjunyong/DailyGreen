//
//  FeedViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit
import XLPagerTabStrip

class FeedViewController: UIViewController, IndicatorInfoProvider{
    
    lazy var getFeedDataManager = FeedDataManager()
    lazy var likeDataManager = LikeDataManager()
    lazy var feedSearchDataManager = FeedSearchDataManager()
    var postIdxs = [Int]()
    var captions = [String]()
    var nickNames = [String]()
    var isFollowings = [Int]()
    var isPostLikes = [Int]()
    var profileUrl = [String]()
    var feedUrls = [Array<String>]()
    var commentTotals = [Int]()
    var postLikeTotals = [Int]()
    var childNumber: String = ""
    var communityIdx: Int?
    var community: String?
    
    var delegate: PagerTabbarViewController?
    
    @IBAction func write(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WriteScene", bundle: nil)
        guard let writeVC = storyboard.instantiateViewController(withIdentifier: "writeVC") as? WriteStep1ViewController else{return}
        writeVC.communityName = self.community
        writeVC.communityIdx = self.communityIdx
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
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
    
    
    override func viewDidLoad() {
        writeButton.setTitle("", for: .normal)
        super.viewDidLoad()
        configureTableView()
        showIndicator()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFeedDataManager.getFeedData(delegate: self, communityIdx: self.communityIdx!, page: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "feedCell")
    }
    func getEntireFeedData(){
        getFeedDataManager.getFeedData(delegate: self, communityIdx: self.communityIdx!, page: 1)
    }

    func searchFeedResult(keyword : String){
        if communityIdx != nil, keyword.count > 0{
            feedSearchDataManager.getFeedSearchData(delegate: self, communityIdx: communityIdx!, page: 1, keyword: keyword)
        }
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
    @objc func report(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "ReportViewScene", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "ReportVC") as? ReportViewController else{return}
        VC.idx = sender.tag
        VC.sort = "p"
        self.present(VC, animated: true, completion: nil)
        
    }
    
    @objc func like(_ sender: UIButton){
        let postIdx = sender.tag - 100
        let params = LikeRequest(postIdx: postIdx)
        likeDataManager.postLike(params, delegate: self)
    }
    
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nickNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedTableViewCell else{return UITableViewCell()}
        cell.feedUrlsForRow = self.feedUrls[idx]
        
        if self.feedUrls[idx].count > 1 {
            cell.indicatorImageView.image = UIImage(named: "pindicator1\(feedUrls[idx].count)")
        }else{
            cell.indicatorImageView.image = nil
        }
        
        cell.nickNameLabel.text = nickNames[idx]
        cell.profileImageView.load(strUrl: self.profileUrl[idx])
        cell.bodyLabel.text = self.captions[idx]
        cell.numOfLikeLabel.text = "\(self.postLikeTotals[idx])명이"
//        cell.numOfCommentLabel.text = "\(self.commentTotals[idx])"
        cell.likeButton.tag = self.postIdxs[idx] + 100
        cell.reportButton.tag = self.postIdxs[idx]
        cell.reportButton.addTarget(self, action: #selector(report(_:)), for: .touchUpInside)
        cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
        if isPostLikes[idx] == 1{
            cell.likeImageView.image = UIImage(named: "bheartFill")
        }else{
            cell.likeImageView.image = UIImage(named: "bheart")
        }
        if isFollowings[idx] == 1{
            cell.followImageView.isHidden = false
        }else{
            cell.followImageView.isHidden = true
        }
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530
    }
}

extension FeedViewController {
    func didSuccessFeed(message: String, results: [FeedResult?] , keyword: String?){
        postIdxs = [Int]()
        captions = [String]()
        nickNames = [String]()
        isFollowings = [Int]()
        isPostLikes = [Int]()
        profileUrl = [String]()
        feedUrls = [Array<String>]()
        commentTotals = [Int]()
        postLikeTotals = [Int]()
        
        var urlArr = [String]()
        for result in results{
            urlArr = [String]()
            guard let postInfoObj = result?.postInfoObj else{return}
            self.captions.append(postInfoObj.caption)
            self.nickNames.append(postInfoObj.nickname)
            self.profileUrl.append(postInfoObj.profilePhotoUrl)
            self.isFollowings.append(postInfoObj.isFollowing)
            self.isPostLikes.append(postInfoObj.isPostLiked)
            self.commentTotals.append(postInfoObj.commentTotal)
            self.postLikeTotals.append(postInfoObj.postLikeTotal)
            self.postIdxs.append(postInfoObj.postIdx)
            
            guard let urls = result!.postPhotoUrlListObj else{continue}
            for feedUrl in urls.urlList{
                urlArr.append(feedUrl.url)
            }
            self.feedUrls.append(urlArr)
        }
        
        if postIdxs.count == 0{
            emptyLabel.isHidden = false
            if keyword != nil {
                configureEmptyLabel(type: 1)
            }else{
                configureEmptyLabel(type: 0)
            }
        }else{
            emptyLabel.isHidden = true
        }
        self.tableView.reloadData()
        dismissIndicator()
    }
    
    func didSuccessLike(message: String){
//        self.presentAlert(title: message)
        getFeedDataManager.getFeedData(delegate: self, communityIdx: self.communityIdx!, page: 1)
    }
    
    func failedToRequest(message: String){
//        self.presentAlert(title: message)
    }
}




