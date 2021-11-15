//
//  ShopPagerViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit
import XLPagerTabStrip

class ShopPagerViewController: ButtonBarPagerTabStripViewController {
    
    
    var naviTitle = ""
    
    let naviShadow: UIView = {
       let view = UIView()
        view.backgroundColor = .dark1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    @IBOutlet weak var searchContentView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var pagerBarDivideView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    override func viewDidLoad() {
        configurePager()
        super.viewDidLoad()
        configureNavi()
        configureSearchBar()
    }
    
    
    private func configureSearchBar(){
        
        filterButton.setTitle("", for: .normal)
        searchButton.setTitle("", for: .normal)
        searchContentView.layer.cornerRadius = 16
        searchContentView.layer.borderColor = UIColor.primary.cgColor
        searchContentView.layer.borderWidth = 2
    }
    private func configureNavi(){
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
        

        let chatButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: 44,
            height: 44))
        chatButton.setImage(UIImage(named: "icChat"), for: .normal)
//        chatButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        let chatBarButtonItem = UIBarButtonItem(customView: chatButton)
        let bellButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: 44,
            height: 44))
        bellButton.setImage(UIImage(named: "icBell"), for: .normal)
//        bellButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        let bellBarButtonItem = UIBarButtonItem(customView: bellButton)
        
        self.navigationItem.rightBarButtonItems = [chatBarButtonItem, bellBarButtonItem]
        
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

        let child1 = UIStoryboard.init(name: "ShopPagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "EntireShopVC") as! EntireShopViewController
        child1.childNumber = "전체"
        let child2 = UIStoryboard.init(name: "ShopPagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "BookMarkShopVC") as! BookMarkShopViewController
        child2.childNumber = "관심상점"
        
        
      return [child1, child2]

    }
    
}
