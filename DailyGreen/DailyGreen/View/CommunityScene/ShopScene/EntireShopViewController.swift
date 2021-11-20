//
//  EntireShopViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit
import XLPagerTabStrip

class EntireShopViewController : UIViewController, IndicatorInfoProvider{
    
    lazy var entireShopDataManger = EntireShopDataManager()
    lazy var likeShopDataManger = LikeShopDataManager()
    
    var shopIdxArr = [Int]()
    var shopNameArr = [String]()
    var locationDetailArr = [String]()
    var urlArr = [String]()
    var isShopLikedArr = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    var childNumber: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        entireShopDataManger.getEntireShop(delegate: self, page: 1)

    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "EntireShopTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EntireCell")
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(title: "\(childNumber)")

    }
    
    @objc func likeShop(_ sender: UIButton){
        
        let shopIdx = sender.tag - 100
        let params = LikeShopRequest(shopIdx: shopIdx)
        likeShopDataManger.postShopLike(params, delegate: self)
        
    }
    @objc func shopDetail(_ sender: UIButton){
        guard let ShopDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "shopDetailVC") as? ShopDetailViewController else{return}
        ShopDetailVC.shopIdx = sender.tag - 100
        
        self.navigationController?.pushViewController(ShopDetailVC, animated: true)
    }
}
extension EntireShopViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntireCell") as? EntireShopTableViewCell else{return UITableViewCell()}
        
        cell.shopImageView.load(strUrl: urlArr[indexPath.row])
        cell.locationLabel.text = locationDetailArr[indexPath.row]
        cell.titleLabel.text = shopNameArr[indexPath.row]
        
        if isShopLikedArr[indexPath.row] == 1{
            cell.likeButtonImageView.image = UIImage(named: "wheartFill")
            
        }else{
            cell.likeButtonImageView.image = UIImage(named: "wheart")
            
        }
        cell.likeButton.tag = shopIdxArr[indexPath.row] + 100
        cell.detailButton.tag = cell.likeButton.tag
        cell.likeButton.addTarget(self, action: #selector(likeShop(_:)), for: .touchUpInside)
        cell.detailButton.addTarget(self, action: #selector(shopDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
    
    
}

extension EntireShopViewController {
    func didSuccessGetEntireShop(message: String, results: [EntireShopResult?]){
        shopIdxArr = [Int]()
        shopNameArr = [String]()
        locationDetailArr = [String]()
        urlArr = [String]()
        isShopLikedArr = [Int]()
        configureTableView()
        for result in results {
            guard let res = result else{continue}
            shopNameArr.append(res.shopName)
            urlArr.append(res.url)
            isShopLikedArr.append(res.isShopLiked)
            shopIdxArr.append(res.shopIdx)
            locationDetailArr.append(res.locationDetail)
            
        }
        tableView.reloadData()
    }
    func didSuccessLikeShop(message: String){
        self.presentAlert(title: message)
    }
    func failedToRequest(message: String){
        
    }
}
