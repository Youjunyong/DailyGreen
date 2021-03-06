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
    var child1: MeetingViewController?
    var child2: FeedViewController?
    let naviShadow: UIView = {
       let view = UIView()
        view.backgroundColor = .dark1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    @IBOutlet weak var searchContentView: UIView!
    
    @IBOutlet weak var searchKeywordTextField: UITextField!
    
    @IBOutlet weak var pagerBarDivideView: UIView!
    @IBOutlet weak var searchButton: UIButton!
 
    
    @IBAction func keywordEditingChanged(_ sender: Any) {
        
        if searchKeywordTextField.text!.count != 0 {
            if currentIndex == 0 {
                let keyword = searchKeywordTextField.text!
                self.child1?.searchMeetResult(keyword: keyword)
            }else if currentIndex == 1{
                let keyword = searchKeywordTextField.text!
                self.child2?.searchFeedResult(keyword: keyword)
            }
        }else{
            if currentIndex == 0 {
                self.child1?.getEntireMeetData()
            }else if currentIndex == 1{
                self.child2?.getEntireFeedData()
            }
        }

    }
    
    @IBAction func search(_ sender: Any) {
        if currentIndex == 0 {
            let keyword = searchKeywordTextField.text!
            self.child1?.searchMeetResult(keyword: keyword)
        }else if currentIndex == 1{
            let keyword = searchKeywordTextField.text!
            self.child2?.searchFeedResult(keyword: keyword)
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

        let child1 = UIStoryboard.init(name: "PagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "MeetVC") as! MeetingViewController
        child1.communityIdx = self.communityIdx
        child1.community = naviTitle
        child1.childNumber = "모임"
        child1.delegate = self
        self.child1 = child1
        
        
        let child2 = UIStoryboard.init(name: "PagerTabbar", bundle: nil).instantiateViewController(withIdentifier: "FeedVC") as! FeedViewController
        child2.communityIdx = self.communityIdx// chile에 적용 안함
        child2.community = naviTitle// chile에 적용 안함
        child2.delegate = self
        child2.childNumber = "피드"
        self.child2 = child2
      return [child1, child2]

    }
    
}


