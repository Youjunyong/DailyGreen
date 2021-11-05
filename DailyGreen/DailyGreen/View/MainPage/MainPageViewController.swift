//
//  MainPageViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/02.
//

import UIKit

class MainPageViewController: UIViewController{
    
    var gridViews: [CommunityView?] = []
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upperDivider: UIView!
    @IBOutlet weak var lowerDivider: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var communityTitleLabel: UILabel!
    @IBOutlet weak var guideButton: UIButton!
    @IBOutlet weak var cmUpperBodyLabel: UILabel!
    @IBOutlet weak var cmLowerBodyLabel: UILabel!
    @IBOutlet weak var grid00View: CommunityView!
    @IBOutlet weak var grid01View: CommunityView!
    @IBOutlet weak var grid02View: CommunityView!
    @IBOutlet weak var grid10View: CommunityView!
    
    @IBOutlet weak var gridProfileImageView: UIImageView!
    @IBOutlet weak var grid12View: CommunityView!
    @IBOutlet weak var grid20View: CommunityView!
    @IBOutlet weak var grid21View: CommunityView!
    @IBOutlet weak var grid22View: CommunityView!

    
    @IBAction func presentGuide(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Guide", bundle: nil)
        let GuideVC = storyBoard.instantiateViewController(withIdentifier: "GuideVC")
        GuideVC.modalPresentationStyle = .fullScreen
        self.present(GuideVC, animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGridView()
        configureUI()
        configureCollectionView()
        configureTouchEvent()
    }

    private func configureGridView(){
        self.gridViews = [grid00View ,grid01View, grid02View, grid10View, grid12View, grid20View, grid21View, grid22View]
        let nameArr = ["플로깅", "제로웨이스트", "분리배출", "비건레시피", "에너지,물절약", "업사이클링", "차없이 가기", "환경문화"]
        let imageArr = ["grid00", "grid01" , "grid02" , "grid10", "grid12", "grid20", "grid21", "grid22"]
        // DUMMY VALUE
        grid01View.activate = true
        grid21View.activate = true
        grid10View.activate = true
        
        
        for (idx,gridView) in gridViews.enumerated() {
  
            gridView?.nameLabel.text = nameArr[idx]
            gridView?.imageView.image = UIImage(named: imageArr[idx])
        }
        
        gridProfileImageView.layer.cornerRadius = gridProfileImageView.layer.frame.size.height / 2
        gridProfileImageView.layer.borderWidth = 0
        gridProfileImageView.layer.masksToBounds = true
        gridProfileImageView.image = UIImage(named: "다운로드")
        
        
        //MARK: - Touch Event (Drag and Drop)
        gridProfileImageView.isUserInteractionEnabled = true
    }

    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.isScrollEnabled = true
        self.collectionView.isPagingEnabled = false
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: "EventCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "eventCell")
         
    }
    private func configureUI(){
        // MARK: - 네비바를 어떻게해야할지,,, 커스텀 뷰로 해야하나 아니면 커스텀 네비바로 해야하나....
        self.navigationController?.isNavigationBarHidden = true
        
        upperDivider.backgroundColor = UIColor.dark1
        lowerDivider.backgroundColor = UIColor.dark1
        guideButton.setTitle("", for: .normal)
        guideButton.tintColor = .dark1
        let userName = "한나"
        userNameLabel.text = "안녕, \(userName)"
        communityTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        let attributedStr = NSMutableAttributedString(string: communityTitleLabel.text!)
        attributedStr.addAttribute(.foregroundColor , value: UIColor.dark2, range:(communityTitleLabel.text! as NSString).range(of: "그린이") )
        communityTitleLabel.attributedText = attributedStr
        cmUpperBodyLabel.font = UIFont(name: NanumFont.regular, size: 13)
        cmLowerBodyLabel.font = UIFont(name: NanumFont.regular, size: 13)
    }
    
    
    private func configureTouchEvent(){
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.test) )
        singleTapGestureRecognizer.numberOfTapsRequired = 1

        singleTapGestureRecognizer.isEnabled = true

        singleTapGestureRecognizer.cancelsTouchesInView = false
        gridProfileImageView.gestureRecognizerShouldBegin(singleTapGestureRecognizer)

        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc private func test(){
        print("#######")
        print(self.isFirstResponder)
        print(self.canResignFirstResponder)
    }
    
    
}
extension MainPageViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}

extension MainPageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventCollectionViewCell else {return UICollectionViewCell() }
        
        
        cell.imageView.image = UIImage(named: "testimage\(indexPath.row + 1)")

        
        
        
        return cell
    }
}


extension MainPageViewController {
    @objc override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: gridProfileImageView)
        if gridProfileImageView.bounds.contains(location) {
            print("did touch in  blue view")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
