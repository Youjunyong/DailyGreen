//
//  MyPageViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit

class MyPageViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gaugeFrameView: UIView!
    @IBOutlet weak var levelWidth: NSLayoutConstraint!
    @IBOutlet weak var levelGaugeView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lvView: UIView!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
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
        let url = UserDefaults.standard.string(forKey: "profilePhotoUrl")
        profileImage.load(strUrl: url!)
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
        
        //API
        
//        bioLabel.text  = ""
        
        
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
