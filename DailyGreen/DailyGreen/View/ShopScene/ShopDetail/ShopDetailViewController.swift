//
//  ShopDetailViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//

import UIKit
import SafariServices

class ShopDetailViewController: UIViewController {
    
    lazy var shopDetailDataManager = ShopDetailDataManager()

    var shopIdx: Int?
    var shopUrlList = [String]()
    var website: String?
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bioTextView: UITextView!
  
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var websiteButton: UIButton!
    
    @IBAction func hyperLink(_ sender: Any) {
        if website != nil{
            let blogUrl = NSURL(string: website!)
            let blogSafariView: SFSafariViewController = SFSafariViewController(url: blogUrl as! URL)
            self.present(blogSafariView, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상점 보기"
        configureUI()
        shopDetailDataManager.getShopDetail(delegate: self, shopIdx: self.shopIdx!)
        configureNaviUnderView()
    }
    
    
    private func configureNaviUnderView(){
        let underView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .dark1
            return view
        }()
        
        view.addSubview(underView)
        NSLayoutConstraint.activate([
            underView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            underView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            underView.heightAnchor.constraint(equalToConstant: 1),
            
            underView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
    }
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.isScrollEnabled = true
        self.collectionView.isPagingEnabled = true
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: "ShopCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    

    private func configureUI(){

        websiteButton.setTitle("", for: .normal)
        profileImageView.layer.cornerRadius = 24
        profileImageView.contentMode = .scaleAspectFill
        nickNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        shopNameLabel.font = UIFont(name: NanumFont.bold, size: 20)
        locationLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)

        bioTextView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        bioTextView.isEditable = false
    }
    
}
extension ShopDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / UIScreen.main.bounds.size.width)
        switch page{
        case 0:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(shopUrlList.count)")
        case 1:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(shopUrlList.count)")
        case 2:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(shopUrlList.count)")
        case 3:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(shopUrlList.count)")
        case 4:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(shopUrlList.count)")
        default:
            break
        }
    }
    
}

extension ShopDetailViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shopUrlList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell() }
        
        cell.shopImageView.load(strUrl: shopUrlList[indexPath.row])
        
        
        return cell
    }
    
}

extension ShopDetailViewController {
    
    func didSuccessGetShopDetail(message: String, results: ShopDetailResult?){
//        self.presentAlert(title: message)
        guard let shopInfo = results?.shopInfoObj else{return}
        shopNameLabel.text = shopInfo.shopName
        locationLabel.text =  shopInfo.locationDetail
        bioTextView.text = shopInfo.bio
        nickNameLabel.text = shopInfo.nickname

        
        website = shopInfo.website
        profileImageView.load(strUrl: shopInfo.profilePhotoUrl)
        
        
        guard let urlList = results?.shopPhotoUrlList else{return}
        for list in urlList {
            guard let url = list?.url else{continue}
            shopUrlList.append(url)
        }
        indicatorImageView.image = UIImage(named: "pindicator1\(shopUrlList.count)")
        configureCollectionView()
    }
    
    func failedToRequest(message: String) {
//        self.presentAlert(title: message)
    }
}
