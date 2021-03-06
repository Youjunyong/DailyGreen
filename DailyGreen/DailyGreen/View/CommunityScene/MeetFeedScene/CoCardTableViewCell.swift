//
//  CoCardTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit

class CoCardTableViewCell: UITableViewCell {

    
    var isHaveHashTag: Bool? {
        didSet{
            if isHaveHashTag == true {
                hashTagView1.isHidden = false
                hashTagView2.isHidden = false
                hashTagView3.isHidden = false
            }else{
                hashTagView1.isHidden = true
                hashTagView2.isHidden = true
                hashTagView3.isHidden = true
            }
        }
    }


    
    @IBOutlet weak var dimmingView: UIView!
    
    @IBOutlet weak var hashTagView1: UIView!
    @IBOutlet weak var hashTag1: UILabel!
    
    @IBOutlet weak var hashTagView2: UIView!
    @IBOutlet weak var hashTag2: UILabel!
    
    @IBOutlet weak var hashTagView3: UIView!
    @IBOutlet weak var hashTag3: UILabel!
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var centerDivideView: UIView!
    
    @IBOutlet weak var participateButton: UIButton!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upperImageView: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var maxPeopleNum: UILabel!
    @IBOutlet weak var participateLabel: UILabel!
    
    @IBOutlet weak var devideViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var participateProfileImageView: UIImageView!
    
    
    @IBOutlet weak var participateProfileImageView2: UIImageView!
    
    @IBOutlet weak var participateProfileImageView3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        participateProfileImageView.layer.cornerRadius = 10
        participateProfileImageView.contentMode = .scaleToFill
        participateProfileImageView2.layer.cornerRadius = 10
        participateProfileImageView2.contentMode = .scaleToFill
        
        participateProfileImageView3.layer.cornerRadius = 10
        participateProfileImageView3.contentMode = .scaleToFill
        
        
        hashTag1.font = UIFont.systemFont(ofSize: 13)
        hashTag2.font = UIFont.systemFont(ofSize: 13)
        hashTag3.font = UIFont.systemFont(ofSize: 13)
        hashTagView1.backgroundColor = .light1
        hashTagView2.backgroundColor = .light1
        hashTagView3.backgroundColor = .light1
        
        hashTagView1.layer.cornerRadius = 15
        hashTagView2.layer.cornerRadius = 15
        hashTagView3.layer.cornerRadius = 15

        
        bodyLabel.textColor = .grayLongtxt
        centerDivideView.backgroundColor = .dark1
        
        dimmingView.layer.cornerRadius = 24
        dimmingView.backgroundColor = .dimmingView
        dimmingView.layer.masksToBounds = true
        dimmingView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner ]
        
        upperImageView.layer.cornerRadius = 24
        upperImageView.layer.masksToBounds = true
        upperImageView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner ]

        
        participateLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        
        participateLabel.text = "자세히 보기"
        participateLabel.textColor = UIColor.dark2
        categoryLabel.font = UIFont(name: NanumFont.bold, size: 15)
        categoryView.layer.cornerRadius = 18
        categoryView.backgroundColor = .white
        
        
        footerView.layer.cornerRadius = 24
        footerView.layer.borderColor = UIColor.primary.cgColor
        footerView.layer.borderWidth = 2
        
        profileImageView.layer.cornerRadius = 18
        profileImageView.contentMode = .scaleAspectFill
    
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        
        participateButton.setTitle("", for: .normal)

    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
