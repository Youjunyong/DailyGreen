//
//  CommunityTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/09.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage1: UIImageView!
    @IBOutlet weak var profileImage2: UIImageView!
    @IBOutlet weak var profileImage3: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cImageView: UIImageView!
    @IBOutlet weak var pushPagerTabVCButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var numOfFollowerLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 16
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.primary.cgColor
        backView?.layer.shadowColor = UIColor.black.cgColor
        backView?.layer.shadowOpacity = 0.12
        backView?.layer.shadowRadius = 4
        backView?.layer.shadowOffset = CGSize(width: 3, height: 3)
        cImageView.backgroundColor = .none
        
        
        profileImage1.layer.cornerRadius = 10
        profileImage2.layer.cornerRadius = 10
        profileImage3.layer.cornerRadius = 10
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
