//
//  MyPageViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit

class MyPageViewController: UIViewController{
    
    lazy var dimmingView = DimmingView()
    lazy var myPageGetDataManager = MyPageGetDataManager()
    lazy var deleteMeetDataManager = DeleteMeetDataManager()
    lazy var participateMeetData = ParticipateMeetDataManager()
    
    
    
    let naviShadowView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dark1
        return view
    }()
    
    var isNotFirst = false
    var userIdx: Int?
    
    var divideIdx: Int?
    
    var cInfoLocationDetail = [String]()
    var cInfoIdx = [Int]()
    var cInfoWhen = [String]()
    var cInfoName = [String]()
    var cInfoType = [String]()
    
    var pInfoLocationDetail = [String]()
    var pInfoIdx = [Int]()
    var pInfoWhen = [String]()
    var pInfoName = [String]()
    var pInfoType = [String]()
    
    
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    

    
    
    @IBOutlet weak var createdEventLabel: UILabel!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
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
    
    @IBOutlet weak var devideView6: UIView!
    
    

    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.userIdx != nil {
            myPageGetDataManager.getMeetData(delegate: self, userIdx: self.userIdx!)
        }
        if CommunityData.shared.subscribedList.count < 5{
            collectionViewHeightConstraint.constant = 80
        }else{
            collectionViewHeightConstraint.constant = 170
        }
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

        
        createdEventLabel.font = UIFont(name: NanumFont.bold, size: 20)
        profileImage.layer.cornerRadius = 53
        profileImage.contentMode = .scaleAspectFill
        lineSpace()
        lvView.layer.cornerRadius = 14
        lvView.layer.borderWidth = 1
        lvView.layer.borderColor = UIColor.dark2.cgColor
        lvLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        
        gaugeFrameView.layer.cornerRadius = 16
        gaugeFrameView.layer.borderWidth = 1
        gaugeFrameView.layer.borderColor = UIColor.dark2.cgColor
        
        levelGaugeLabel.font = UIFont(name: NanumFont.regular , size: 13)
        
        divideView1.backgroundColor = .dark1
        divideView2.backgroundColor = .dark1
        divideView3.backgroundColor = .dark1
        
        
        bioTitleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        communityTitleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        bioLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        
        scoreFeedLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreFeedLabel.textColor = .dark2
        scoreBadgeLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreBadgeLabel.textColor = .dark2
        scoreWorkshopLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        scoreWorkshopLabel.textColor = .dark2
        view.addSubview(naviShadowView)
        NSLayoutConstraint.activate([
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            naviShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
    
    private func lvGaugeSet(exp : Int){
        if isNotFirst{return}
        self.isNotFirst = true
        
        lazy var whiteView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        let entireWidth = gaugeVIew.frame.width
        let proportion = (CGFloat(exp).truncatingRemainder(dividingBy: 1000)) / CGFloat(1000)
        
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
    
    @objc func deleteMeet(_ sender: UIButton){
        let clubIdx = sender.tag - 100
        let params = DeleteMeetRequest(clubIdx: clubIdx)
        deleteMeetDataManager.patchDeleteMeet(params, delegate: self, clubIdx: clubIdx)
    }
    @objc func cancelMeet(_ sender: UIButton){
        let clubIdx = sender.tag - 100
        let params = ParticipateMeetRequest(clubIdx: clubIdx)
        participateMeetData.myPageParticiPateMeet(params, delegate: self)
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
        
        return cell
        
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewHeightConstraint.constant = 110 * CGFloat(cInfoName.count + pInfoName.count)
        
        return cInfoName.count + pInfoName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell") as? MyPageTableViewCell else{return UITableViewCell()}
        if indexPath.row < cInfoIdx.count {
            cell.dateLabel.text = self.cInfoLocationDetail[indexPath.row]
            cell.dismissButton.tag = self.cInfoIdx[indexPath.row] + 100
            cell.dismissButton.addTarget(self, action: #selector(deleteMeet(_:)), for: .touchUpInside)
            cell.titleLabel.text = self.cInfoName[indexPath.row]
            cell.dateLabel.text = cInfoWhen[indexPath.row]
            cell.locationLabel.text = cInfoLocationDetail[indexPath.row]
            cell.typeLabel.text = cInfoType[indexPath.row]
        }else{
            let idx = indexPath.row - cInfoIdx.count
            cell.openerImageView.isHidden = true
            cell.titleLeadingConstraint.constant = 10
            cell.dateLabel.text = self.pInfoLocationDetail[idx]
            cell.dismissButton.tag = self.pInfoIdx[idx] + 100
            cell.dismissButton.addTarget(self, action: #selector(cancelMeet(_:)), for: .touchUpInside)
            cell.titleLabel.text = self.pInfoName[idx]
            cell.dateLabel.text = pInfoWhen[idx]
            cell.locationLabel.text = pInfoLocationDetail[idx]
            cell.typeLabel.text = pInfoType[idx]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension MyPageViewController{
    func didSuccessGet(message: String, results: InfoResult){
        let myInfo = results.myInfo
        let createdInfo = results.createdInfo
        let participatingInfo = results.participatingInfo
        scoreBadgeLabel.text = "\(myInfo.badgeCnt)개"
        scoreFeedLabel.text = "\(myInfo.createdPostCnt)회"
        scoreWorkshopLabel.text = "\(myInfo.participationCnt)회"
        lvLabel.text = "Lv.\(myInfo.exp / 1000 + 1) "
        lvGaugeSet(exp: myInfo.exp)
        profileImage.load(strUrl: myInfo.profilePhotoUrl)
        UserDefaults.standard.set(myInfo.profilePhotoUrl, forKey: "profilePhotoUrl") // 회원가입시 받아오기 성공하면 필요없는 코드

        gaugeVIew.setGradient(color1: .grayGreen, color2: .dark2)
        bioLabel.text = myInfo.bio
        UserDefaults.standard.set(bioLabel.text, forKey: "bio")
        
        cInfoLocationDetail = [String]()
        cInfoIdx = [Int]()
        cInfoWhen = [String]()
        cInfoName = [String]()
        cInfoType = [String]()
        
        pInfoLocationDetail = [String]()
        pInfoIdx = [Int]()
        pInfoWhen = [String]()
        pInfoName = [String]()
        pInfoType = [String]()
        for info in createdInfo {
            guard let location = info?.locationDetail else{break}
            guard let idx = info?.idx else{break}
            guard let when = info?.when else{break}
            guard let name = info?.name else{break}
            guard let type = info?.type else{break}
            cInfoLocationDetail.append(location)
            cInfoIdx.append(idx)
            cInfoWhen.append(when)
            cInfoName.append(name)
            cInfoType.append(type)
        }
        
        for info in participatingInfo {
            guard let location = info?.locationDetail else{break}
            guard let idx = info?.idx else{break}
            guard let when = info?.when else{break}
            guard let name = info?.name else{break}
            guard let type = info?.type else{break}
            pInfoLocationDetail.append(location)
            pInfoIdx.append(idx)
            pInfoWhen.append(when)
            pInfoName.append(name)
            pInfoType.append(type)
        }

        tableView.reloadData()
        contentViewHeightConstraint.constant = tableView.frame.origin.y + CGFloat((cInfoIdx.count + pInfoIdx.count) * 110) + 100
    }
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
}


extension MyPageViewController {
    func didSuccessDeleteMeet(message: String){
        presentDimmingView(message: message)
        myPageGetDataManager.getMeetData(delegate: self, userIdx: self.userIdx!)
    }
    
    func didSuccessParticiPateMeet(message: String){
        presentDimmingView(message: message)
        myPageGetDataManager.getMeetData(delegate: self, userIdx: self.userIdx!)
    }
    
}
