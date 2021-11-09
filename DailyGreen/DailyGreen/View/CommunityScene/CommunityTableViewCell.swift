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
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var numOfFollowerLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 16
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.primary.cgColor
        cImageView.backgroundColor = .none
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
