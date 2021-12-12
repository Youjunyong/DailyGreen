//
//  ShopPagerViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit
import XLPagerTabStrip

class ShopPagerViewController: ButtonBarPagerTabStripViewController {
    
    
    var naviTitle = "상점 보기"
    var child1 : EntireShopViewController?
    let naviShadow: UIView = {
       let view = UIView()
        view.backgroundColor = .dark1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var searchContentView: UIView!
    
    
    @IBOutlet weak var pagerBarDivideView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchKeywordTextField: UITextField!
    
    @IBAction func search(_ sender: Any) {
        if currentIndex == 0{
            if searchKeywordTextField.text!.count == 0 {
                presentAlert(title: "검색 키워드를 입력해주세요")
                return
            }
            child1?.search(keyword: searchKeywordTextField.text!)
        }else{
            if searchKeywordTextField.text!.count == 0 {
                presentAlert(title: "검색 키워드를 입력해주세요")
                return
            }
            moveTo(viewController: child1!)
            child1?.search(keyword: searchKeywordTextField.text!)
        }
        
    }
    
    
    override func viewDidLoad() {
        configurePager()
        super.viewDidLoad()
        configureNavi()
        configureSearchBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideKeyboardWhenTappedBackground()

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
        view.addSubview(naviShadow)
        NSLayoutConstraint.activate([
            naviShadow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        settings.style.selectedBarBackgroundColor = UIColor.PagerIndicator
        settings.style.buttonBarItemFont = UIFont(name: NanumFont.bold, size: 16)!
        settings.style.selectedBarHeight = 3
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
        child1.delegate = self
        self.child1 = child1
        child1.childNumber = "전체"
        let child2 = UIStoryboard.init(name: "ShopPagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "BookMarkShopVC") as! BookMarkShopViewController
        child2.childNumber = "관심상점"
        
        
      return [child1, child2]

    }
    
}
