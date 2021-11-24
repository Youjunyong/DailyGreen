//
//  CommunityListCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/24.
//

import UIKit

class CommunityListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var communityView: UIView!
    @IBOutlet weak var communityLabel: UILabel!
    @IBOutlet weak var communityImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        communityImageView.layer.cornerRadius = 24
        
        
        communityView.layer.cornerRadius = 24
        communityView.layer.shadowColor = UIColor.black.cgColor
        communityView.layer.shadowOpacity = 0.12
        communityView.layer.shadowRadius = 4
        communityView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

}
