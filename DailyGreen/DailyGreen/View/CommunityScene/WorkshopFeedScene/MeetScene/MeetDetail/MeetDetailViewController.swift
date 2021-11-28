//
//  MeetDetailViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import UIKit

class MeetDetailViewController: UIViewController {
    
    lazy var meetDetailDataManager = MeetDetailDataManager()
    var clubIdx: Int?
    var communityName: String?
    var isRegular: Int?
    var meetUrlList = [String]()
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var dDayLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        if isRegular == 1{
            title = "\(communityName!) 정기모임"
        }else{
            title = "\(communityName!) 모임"
        }
        configureUI()
        bioTextView.isEditable = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        meetDetailDataManager.getMeetDetail(delegate: self, clubIdx: clubIdx!)

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
        let nib = UINib(nibName: "MeetDetailCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    
    
    private func configureUI(){
    
        profileImageView.layer.cornerRadius = 24
        profileImageView.contentMode = .scaleAspectFill
        nickNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        shopNameLabel.font = UIFont(name: NanumFont.bold, size: 20)
        locationLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        phoneLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        websiteLabel.font =  UIFont.systemFont(ofSize: 15, weight: .regular)
        bioTextView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
}
extension MeetDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 1:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 2:
            print(page)
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 3:
            print(page)
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 4:
            print(page)
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        default:
            print("default")
            break
        }
    }

    
}

extension MeetDetailViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return meetUrlList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MeetDetailCollectionViewCell else {return UICollectionViewCell() }
        cell.MeetDetailImageView.load(strUrl: meetUrlList[indexPath.row])
        return cell
    }
    
}

extension MeetDetailViewController {
    func didSuccessGetMeetDetail(message: String, results: MeetDetailResult){
        if let clubInfoObj = results.clubInfoObj {
            shopNameLabel.text =  clubInfoObj.clubName
//            clubInfoObj.clubIdx
            websiteLabel.text =  clubInfoObj.fee
            if clubInfoObj.fee.count > 3 {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                var intFee = clubInfoObj.fee
                intFee.removeLast()
                
                guard let res = numberFormatter.string(from: NSNumber(value:Double(intFee)!)) else{return}
                
                websiteLabel.text = "\(res) 원"
            }
            print(clubInfoObj.fee)
            phoneLabel.text = clubInfoObj.when
            locationLabel.text =  clubInfoObj.locationDetail
            clubInfoObj.maxPeopleNum
            nickNameLabel.text =  clubInfoObj.nickname
            profileImageView.load(strUrl: clubInfoObj.profilePhotoUrl)
            bioTextView.text = clubInfoObj.bio
            dDayLabel.text = clubInfoObj.Dday
        }
        
        
        
        if let urls = results.clubPhotoUrlListObj?.urlList , urls.count > 0{
            for url in urls{
                guard let url = url?.clubPhotoUrl else{break}
                self.meetUrlList.append(url)
            }
            if meetUrlList.count > 1{
                self.indicatorImageView.image = UIImage(named: "pindicator1\(meetUrlList.count)")

            }
            self.presentAlert(title: message)
        }
        
        configureCollectionView()
    }
    
        func failedToRequest(message: String){
            self.presentAlert(title: message)
            
        }
    
}
