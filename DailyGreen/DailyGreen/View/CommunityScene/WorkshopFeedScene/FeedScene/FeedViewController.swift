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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
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
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(childNumber)")
    }
    
    @objc func like(_ sender: UIButton){
        let postIdx = sender.tag - 100
        let params = LikeRequest(postIdx: postIdx)
        likeDataManager.postLike(params, delegate: self)
        // 네트워크통신은 추가했으나, 버튼View가 heartFill로 바뀌는 토글과정은 추가하지 않았음.
    }
    
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(nickNames)
        return nickNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idx = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedTableViewCell else{return UITableViewCell()}
        cell.feedUrlsForRow = self.feedUrls[idx]
        
        if self.feedUrls[idx].count > 1 {
            cell.indicatorImageView.image = UIImage(named: "pindicator1\(feedUrls[idx].count)")
        }else{
            cell.indicatorImageView.backgroundColor = .red
        }
        
        cell.nickNameLabel.text = nickNames[idx]
        cell.profileImageView.load(strUrl: self.profileUrl[idx])
        cell.bodyLabel.text = self.captions[idx]
        cell.numOfLikeLabel.text = "\(self.postLikeTotals[idx])명이"
        cell.numOfCommentLabel.text = "\(self.commentTotals[idx])"
        cell.likeButton.tag = self.postIdxs[idx] + 100
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
        return 600
    }
}

extension FeedViewController {
    func didSuccessFeed(message: String, results: [FeedResult?]){
        postIdxs = [Int]()
        captions = [String]()
        nickNames = [String]()
        isFollowings = [Int]()
        isPostLikes = [Int]()
        profileUrl = [String]()
        feedUrls = [Array<String>]()
        commentTotals = [Int]()
        postLikeTotals = [Int]()
        
        configureTableView()
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
        self.tableView.reloadData()
    }
    
    func didSuccessLike(message: String){
        self.presentAlert(title: message)

        
    }
    
    func failedToRequest(message: String){
        self.presentAlert(title: message)
    }
}




