//
//  MyPageViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit

class MyPageViewController: UIViewController{
    
    
    lazy var myPageGetDataManager = MyPageGetDataManager()
    var userIdx: Int?
//    var badgeCnt : Int?
//    var createdPostCnt : Int?
//    var nickname : String?
//    var exp: Int?
//    var participationCnt: Int?
//    var profilePhotoUrl: String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gaugeFrameView: UIView!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lvView: UIView!
    
    @IBOutlet weak var gaugeVIew: UIView!
    @IBOutlet weak var levelGaugeLabel: UILabel!
    @IBOutlet weak var lvLabel: UILabel!
    
    @IBOutlet weak var divideView1: UIView!
    
    @IBOutlet weak var divideView2: UIView!
    @IBOutlet weak var divideView3: UIView!
    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var communityTitleLabel: UILabel!
    
    
    @IBOutlet weak var scoreWorkshopLabel: UILabel!
    
    @IBOutlet weak var scoreFeedLabel: UILabel!
    
    @IBOutlet weak var scoreBadgeLabel: UILabel!
    
    
    @IBAction func settingTouched(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SettingScene", bundle: nil)
        let SettingVC = storyboard.instantiateViewController(withIdentifier: "SettingVC")
        self.navigationController?.pushViewController(SettingVC, animated: true)

    }
    @IBOutlet weak var settingTouched: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = .black
        title = "나의 계정"
        configureUI()
        configureCollectionView()
        configureTableView()
        if userIdx == nil {
            self.userIdx = UserDefaults.standard.integer(forKey: "userIdx")
        }
        
        
        if self.userIdx != nil {
            myPageGetDataManager.getMeetData(delegate: self, userIdx: self.userIdx!)

        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MyPageTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MyPageCell")
        tableView.separatorStyle = .none
    }
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CommunityListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CommunityListCell")
        
    }
    private func configureUI(){
        
        
        profileImage.layer.cornerRadius = 53
        profileImage.contentMode = .scaleAspectFill
//        let url = UserDefaults.standard.string(forKey: "profilePhotoUrl")
//        profileImage.load(strUrl: url!)
        lineSpace()
        
        lvView.layer.cornerRadius = 14
        lvView.layer.borderWidth = 1
        lvView.layer.borderColor = UIColor.dark2.cgColor
        lvLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        
        gaugeFrameView.layer.cornerRadius = 16
        gaugeFrameView.layer.borderWidth = 1
        gaugeFrameView.layer.borderColor = UIColor.dark2.cgColor
        
        levelGaugeLabel.font = UIFont(name: NanumFont.regular , size: 13)
        
        divideView1.backgroundColor = .dark2
        divideView2.backgroundColor = .dark2
        divideView3.backgroundColor = .dark2
        
        bioTitleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        communityTitleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        bioLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        
        scoreFeedLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreFeedLabel.textColor = .dark2
        scoreBadgeLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreBadgeLabel.textColor = .dark2
        scoreWorkshopLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreWorkshopLabel.textColor = .dark2
        

        
    }
    private func lvGaugeSet(exp : Int){
        lazy var whiteView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        let entireWidth = gaugeVIew.frame.width
        let proportion = CGFloat(exp) / CGFloat(1000)
        view.addSubview(whiteView)
        NSLayoutConstraint.activate([
            whiteView.trailingAnchor.constraint(equalTo: gaugeVIew.trailingAnchor),
            whiteView.centerYAnchor.constraint(equalTo: gaugeVIew.centerYAnchor),
            whiteView.heightAnchor.constraint(equalTo: gaugeVIew.heightAnchor),
            whiteView.widthAnchor.constraint(equalToConstant: entireWidth - (entireWidth * proportion) )
        ])
        
        
        
        
    }
    private func lineSpace(){
        let attrString = NSMutableAttributedString(string: bioLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        bioLabel.attributedText = attrString
    }
    
    
}


extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CommunityData.shared.subscribedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityListCell", for: indexPath) as? CommunityListCollectionViewCell else{return UICollectionViewCell()}
        let subscribeIdx = CommunityData.shared.subscribedList[indexPath.row]
        let imageName = CommunityData.shared.imageArr[subscribeIdx]
        cell.communityImageView.image = UIImage(named: imageName)
        cell.communityLabel.text = CommunityData.shared.nameArr[subscribeIdx]
        
        print("inputed," , CommunityData.shared.nameArr[subscribeIdx])
        return cell
        
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") as? MyPageTableViewCell else{return UITableViewCell()}
        
        
//        cell.openerImageView.removeFromSuperview()
//        NSLayoutConstraint.activate([
//            cell.titleLabel.leadingAnchor.constraint(equalTo: cell.categoryView.trailingAnchor, constant: 5)
//        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension MyPageViewController{
    func didSuccessGet(message: String, results: InfoResult){
        let myInfo = results.myInfo
        let participatingInfo = results.participatingInfo
        scoreBadgeLabel.text = "\(myInfo.badgeCnt)회"
        scoreFeedLabel.text = "\(myInfo.createdPostCnt)회"
        scoreWorkshopLabel.text = "\(myInfo.participationCnt)회"
        lvLabel.text = "Lv.\(myInfo.exp / 1000 + 1) "
        lvGaugeSet(exp: myInfo.exp)
        profileImage.load(strUrl: myInfo.profilePhotoUrl)
        print(myInfo.profilePhotoUrl)
        gaugeVIew.setGradient(color1: .grayGreen, color2: .dark2)
        bioLabel.text = myInfo.bio
        print(myInfo.exp)
        
        
        
//        badgeCnt = myInfo.badgeCnt
//        createdPostCnt = myInfo.createdPostCnt
//        nickname =  myInfo.nicknamex

        
        
        
        

        
    }
    func failedToRequest(message: String){
        presentAlert(title: message)

    }
}
