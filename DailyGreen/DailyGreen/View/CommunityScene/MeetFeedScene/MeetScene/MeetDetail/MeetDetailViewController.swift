//
//  MeetDetailViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import UIKit

class MeetDetailViewController: UIViewController {
    
    lazy var meetDetailDataManager = MeetDetailDataManager()
    lazy var participateDataManager = ParticipateMeetDataManager()
    var clubIdx: Int?
    var communityName: String?
    var isRegular: Int?
    var meetUrlList = [String]()
    lazy var dimmingView = DimmingView()
    
    @IBOutlet weak var submitButtonLabel: UILabel!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var divideView: UIView!
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
    @IBOutlet weak var participateLabel: UILabel!
    @IBOutlet weak var participatePeopleNumLabel: UILabel!
    @IBOutlet weak var participateProfileImageview1: UIImageView!
    @IBOutlet weak var profileName1: UILabel!
    @IBOutlet weak var participateProfileImageview2: UIImageView!
    @IBOutlet weak var profileName2: UILabel!
    @IBOutlet weak var participateProfileImageview3: UIImageView!
    @IBOutlet weak var profileName3: UILabel!
    @IBOutlet weak var participateProfileImageview4: UIImageView!
    @IBOutlet weak var restNumLabel: UILabel!
    @IBOutlet weak var profileName4: UILabel!
    @IBOutlet weak var restNumView: UIView!
    @IBOutlet weak var openChatLabel: UILabel!
    @IBOutlet weak var participateView: UIView!
    @IBOutlet weak var openChatTitleLabel: UILabel!
    @IBOutlet weak var openChatLinkLabel: UILabel!
    @IBAction func report(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ReportViewScene", bundle: nil)
        guard let VC = storyboard.instantiateViewController(withIdentifier: "ReportVC") as? ReportViewController else{return}
        VC.idx = clubIdx
        VC.sort = "c"
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        let params = ParticipateMeetRequest(clubIdx: self.clubIdx!)
        participateDataManager.particiPateMeet(params, delegate: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        if isRegular == 1{
            title = "\(communityName!) 정기모임"
        }else{
            title = "\(communityName!) 모임"
        }
        configureUI()
        configureParticipateView()
        configureOpenChat()
        submitButton.setTitle("", for: .normal)
        bioTextView.isEditable = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        meetDetailDataManager.getMeetDetail(delegate: self, clubIdx: clubIdx!)

    }
    
    
    private func configureOpenChat(){
        openChatLabel.font = UIFont(name: NanumFont.bold, size: 17)
        
    }
    
    private func configureParticipateView(){
        profileName1.text = ""
        profileName2.text = ""
        profileName3.text = ""
        profileName4.text = ""
        participateView.layer.borderColor = UIColor.primary.cgColor
        participateView.layer.borderWidth = 2
        
        participateView.layer.cornerRadius = 14
        
        participateLabel.font = UIFont(name: NanumFont.bold, size: 17)
        participateView.layer.shadowColor = UIColor.black.cgColor
        participateView.layer.shadowOpacity = 0.22
        participateView.layer.shadowRadius = 4
        participateView.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        participatePeopleNumLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        restNumLabel.font = UIFont(name: NanumFont.bold, size: 15)
        restNumView.backgroundColor = .primaryLight1
        restNumView.layer.cornerRadius = 18
        restNumView.layer.shadowColor = UIColor.black.cgColor
        restNumView.layer.shadowOpacity = 0.22
        restNumView.layer.shadowRadius = 4
        restNumView.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
        participateProfileImageview1.layer.cornerRadius = 20
        participateProfileImageview1.contentMode = .scaleAspectFill
        participateProfileImageview2.layer.cornerRadius = 20
        participateProfileImageview2.contentMode = .scaleAspectFill
        
        participateProfileImageview3.layer.cornerRadius = 20
        participateProfileImageview3.contentMode = .scaleAspectFill
        
        participateProfileImageview4.contentMode = .scaleAspectFill
        participateProfileImageview4.layer.cornerRadius = 20
        
        
        profileName1.font = UIFont.systemFont(ofSize: 10)
        profileName2.font = UIFont.systemFont(ofSize: 10)
        profileName3.font = UIFont.systemFont(ofSize: 10)
        profileName4.font = UIFont.systemFont(ofSize: 10)
    }
    
    private func presentDimmingView(message: String){

        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alretText = message
        
        view.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        dimmingView.dismissBtn.addTarget(self, action: #selector(removeAlert), for: .touchUpInside)
    }
    
    @objc func removeAlert(){
        dimmingView.removeFromSuperview()
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
        submitButtonLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        reportButton.setTitle("", for: .normal)
        divideView.backgroundColor = .primary
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
        if isRegular == 1 {return}
        
        let page = Int(targetContentOffset.pointee.x / UIScreen.main.bounds.size.width)
        switch page{
        case 0:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 1:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 2:
            
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 3:
            
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        case 4:
            
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(meetUrlList.count)")
        default:
            break
        }
    }

    
}

extension MeetDetailViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if isRegular == 1{
            return meetUrlList.count

        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MeetDetailCollectionViewCell else {return UICollectionViewCell() }
        cell.MeetDetailImageView.load(strUrl: meetUrlList[indexPath.row])
        return cell
    }
    
}

extension MeetDetailViewController {
    func didSuccessGetMeetDetail(message: String, results: MeetDetailResult){
        profileName1.text = ""
        participateProfileImageview1.image = nil
        profileName2.text = ""
        participateProfileImageview2.image = nil
        profileName3.text = ""
        participateProfileImageview3.image = nil
        profileName4.text = ""
        participateProfileImageview4.image = nil
        
        if let clubInfoObj = results.clubInfoObj {
            shopNameLabel.text =  clubInfoObj.clubName
//            clubInfoObj.clubIdx
            websiteLabel.text =  clubInfoObj.fee
            if clubInfoObj.fee.count > 4 {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                var intFee = clubInfoObj.fee
                intFee.removeLast()
                
                guard let res = numberFormatter.string(from: NSNumber(value:Double(intFee)!)) else{return}
                
                websiteLabel.text = "\(res) 원"
            }else{
                websiteLabel.text = "무료"
            }
            if clubInfoObj.kakaoChatLink != nil{
                
                openChatLinkLabel.text =  clubInfoObj.kakaoChatLink!
            }else{
                openChatLabel.text = ""
            }
            phoneLabel.text = clubInfoObj.when
            locationLabel.text =  clubInfoObj.locationDetail
            let max = clubInfoObj.maxPeopleNum
            let now = clubInfoObj.nowFollowing
            
            restNumLabel.text = "잔여 \(max - now)석"
            
            participatePeopleNumLabel.text = "\(now) / \(max)명 참가중"
            
            nickNameLabel.text =  clubInfoObj.nickname
            profileImageView.load(strUrl: clubInfoObj.profilePhotoUrl)
            bioTextView.text = clubInfoObj.bio
            dDayLabel.text = clubInfoObj.Dday
        }
        self.meetUrlList.removeAll()
        if let urls = results.clubPhotoUrlListObj?.urlList , urls.count > 0{
            for url in urls{
                guard let url = url?.clubPhotoUrl else{break}
                self.meetUrlList.append(url)
            }
            if meetUrlList.count > 1{
                self.indicatorImageView.image = UIImage(named: "pindicator1\(meetUrlList.count)")
            }
        }
        
        if let participateListObj = results.participantListObj?.participants{
            
            
            for (idx, participant) in participateListObj.enumerated() {
                guard let imageUrl = participant?.profilePhotoUrl else{break}
                guard let name = participant?.nickname else{break}
                switch idx{
                case 0:
                    profileName1.text = name
                    participateProfileImageview1.load(strUrl: imageUrl)
                case 1:
                    profileName2.text = name
                    participateProfileImageview2.load(strUrl: imageUrl)
                case 2:
                    profileName3.text = name
                    participateProfileImageview3.load(strUrl: imageUrl)
                    
                case 3:
                    profileName4.text = name
                    participateProfileImageview4.load(strUrl: imageUrl)
                default:
                    break
                }
                
            }
        }
        configureCollectionView()
    }
    
        func failedToRequest(message: String){
            self.presentAlert(title: "이미 모집이 종료되었습니다.")
        }
    
}

extension MeetDetailViewController {
    func didSuccessParticiPateMeet(message: String){
        presentDimmingView(message: message)
        meetDetailDataManager.getMeetDetail(delegate: self, clubIdx: clubIdx!)
    }

}
