//
//  CoCardTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit

class CoCardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var centerDivideView: UIView!
    @IBOutlet weak var participateButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upperImageView: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var participateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        
        bodyLabel.textColor = .grayLongtxt
        centerDivideView.backgroundColor = .dark1
        
        upperImageView.layer.cornerRadius = 24
        upperImageView.layer.masksToBounds = true
        upperImageView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner ]

        participateButton.setTitle("", for: .normal)
        participateLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        
        participateLabel.text = "참여하기"
        participateLabel.textColor = UIColor.dark2
        categoryLabel.font = UIFont(name: NanumFont.bold, size: 15)
        categoryView.layer.cornerRadius = 18
        categoryView.backgroundColor = .white
        
        
        footerView.layer.cornerRadius = 24
        footerView.layer.borderColor = UIColor.primary.cgColor
        footerView.layer.borderWidth = 2
        
        
    
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
