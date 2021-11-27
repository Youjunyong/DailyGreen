//
//  PagerTabbarViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit
import XLPagerTabStrip

class PagerTabbarViewController: ButtonBarPagerTabStripViewController {
    
    
    var naviTitle = ""
    var communityIdx: Int?
    
    let naviShadow: UIView = {
       let view = UIView()
        view.backgroundColor = .dark1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    @IBOutlet weak var searchContentView: UIView!
    
    
    @IBOutlet weak var pagerBarDivideView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        configurePager()
        super.viewDidLoad()
        
        configureNavi()
        configureSearchBar()
    }
    
    
    private func configureSearchBar(){
        
        
        searchButton.setTitle("", for: .normal)
        searchContentView.layer.cornerRadius = 16
        searchContentView.layer.borderColor = UIColor.primary.cgColor
        searchContentView.layer.borderWidth = 2
    }
    private func configureNavi(){
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
        

//        let chatButton = UIButton(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: 44,
//            height: 44))
//        chatButton.setImage(UIImage(named: "icChat"), for: .normal)
////        chatButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
//        let chatBarButtonItem = UIBarButtonItem(customView: chatButton)
//        let bellButton = UIButton(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: 44,
//            height: 44))
//        bellButton.setImage(UIImage(named: "icBell"), for: .normal)
////        bellButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
//        let bellBarButtonItem = UIBarButtonItem(customView: bellButton)
//
//        self.navigationItem.rightBarButtonItems = [chatBarButtonItem, bellBarButtonItem]
        
        view.addSubview(naviShadow)
        NSLayoutConstraint.activate([
            naviShadow.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            naviShadow.heightAnchor.constraint(equalToConstant: 1),
            naviShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        title = self.naviTitle
    }
    
    private func configurePager(){
        pagerBarDivideView.backgroundColor = .dark2
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor.primary
        settings.style.buttonBarItemFont = UIFont(name: NanumFont.bold, size: 16)!
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        settings.style.buttonBarLeftContentInset  = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .grayLongtxt
            oldCell?.label.font = UIFont.systemFont(ofSize: 15, weight: .light)
            newCell?.label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            newCell?.label.textColor = .black
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        let child1 = UIStoryboard.init(name: "PagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "MeetVC") as! MeetingViewController
        child1.communityIdx = self.communityIdx
        child1.community = naviTitle
        child1.childNumber = "모임"
        let child2 = UIStoryboard.init(name: "PagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "WorkshopVC") as! WorkshopViewController
        child2.communityIdx = self.communityIdx 
        child2.community = naviTitle
        child2.childNumber = "워크샵"
        let child3 = UIStoryboard.init(name: "PagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "FeedVC") as! FeedViewController
        child3.communityIdx = self.communityIdx// chile에 적용 안함
        child3.community = naviTitle// chile에 적용 안함
        child3.childNumber = "피드"
      return [child1, child2, child3]

    }
    
}
