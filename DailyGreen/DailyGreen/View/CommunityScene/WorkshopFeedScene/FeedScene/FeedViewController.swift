//
//  FeedViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit
import XLPagerTabStrip

class FeedViewController: UIViewController, IndicatorInfoProvider{

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
    lazy var getFeedDataManager = FeedDataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

      super.viewDidLoad()
        configureTableView()
        
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
        }
        
        cell.nickNameLabel.text = nickNames[idx]
        cell.profileImageView.load(strUrl: self.profileUrl[idx])
        cell.bodyLabel.text = self.captions[idx]
        cell.numOfLikeLabel.text = "\(self.postLikeTotals[idx])명이"
        cell.numOfCommentLabel.text = "\(self.commentTotals[idx])"
        if isFollowings[idx] == 1{
            cell.followImageView.isHidden = false
        }else{
            cell.followImageView.isHidden = true
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}

extension FeedViewController {
    func didSuccessFeed(message: String, results: [FeedResult?]){
        
        var urlArr = [String]()
        
        
        for result in results{
            urlArr = [String]()
            self.captions.append(result?.postInfoObj?.caption ?? "")
            self.nickNames.append(result?.postInfoObj?.nickname ?? "")
            self.profileUrl.append(result?.postInfoObj?.profilePhotoUrl ?? "")
            self.isFollowings.append(result?.postInfoObj?.isFollowing ?? 0)
            self.isPostLikes.append(result?.postInfoObj?.isPostLiked ?? 0)
            self.commentTotals.append(result?.postInfoObj?.commentTotal ?? 0)
            self.postLikeTotals.append(result?.postInfoObj?.postLikeTotal ?? 0)
            guard let urls = result!.postPhotoUrlListObj else{continue}
            for feedUrl in urls.urlList{
                urlArr.append(feedUrl.url)
            }
            self.feedUrls.append(urlArr)
        }
    
        
        self.tableView.reloadData()
        
    }
}


