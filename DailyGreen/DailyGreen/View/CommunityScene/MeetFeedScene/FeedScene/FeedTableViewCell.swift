//
//  FeedTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/18.
//

import UIKit

class FeedTableViewCell: UITableViewCell{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet weak var reportButton: UIButton!
//    @IBOutlet weak var commentImageView: UIImageView!
//    @IBOutlet weak var moreCommentButton: UIButton!
    @IBOutlet weak var followImageView: UIImageView!
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var indicatorImageView: UIImageView!
    var feedUrlsForRow = [String]()
    
//    @IBOutlet weak var numOfCommentSubLabel: UILabel!
//    @IBOutlet weak var numOfCommentLabel: UILabel!
    @IBOutlet weak var numOfLikeSubLabel: UILabel!
    @IBOutlet weak var numOfLikeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
//    @IBOutlet weak var commentButton: UIButton!
    
    

    
    
    @IBAction func togleLike(_ sender: Any) {
        if likeImageView.image == UIImage(named: "bheart"){
            likeImageView.image = UIImage(named: "bheartFill")
        }else{
            likeImageView.image = UIImage(named: "bheart")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        configureCollectionView()
        configureUI()
        
        
    }
    private func configureUI(){
        reportButton.setTitle("", for: .normal)
        likeButton.setTitle("", for: .normal)
//        commentButton.setTitle("", for: .normal)
//        moreCommentButton.setTitle("", for: .normal)
//        numOfCommentSubLabel.font = UIFont(name: NanumFont.regular, size: 12)
//        numOfCommentLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        bodyLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        numOfLikeLabel.font = UIFont(name: NanumFont.bold, size: 14)
        numOfLikeSubLabel.font = UIFont(name: NanumFont.bold, size: 14)
        nickNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        profileImageView.layer.cornerRadius = 16
        profileImageView.contentMode = .scaleAspectFill
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
        let nib = UINib(nibName: "FeedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension FeedTableViewCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width

        return CGSize(width: screenWidth, height: 340)
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
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(feedUrlsForRow.count)")

        case 1:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(feedUrlsForRow.count)")

        case 2:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(feedUrlsForRow.count)")
        case 3:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(feedUrlsForRow.count)")
        case 4:
            self.indicatorImageView.image = UIImage(named: "pindicator\(page + 1)\(feedUrlsForRow.count)")
        default:
            print("default")
            break
        }
    }
    
}

extension FeedTableViewCell : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedUrlsForRow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FeedCollectionViewCell else {return UICollectionViewCell() }
        if feedUrlsForRow.count > indexPath.row{
            cell.feedImageView.load(strUrl: feedUrlsForRow[indexPath.row])
        }
        
        return cell
    }
    
}



