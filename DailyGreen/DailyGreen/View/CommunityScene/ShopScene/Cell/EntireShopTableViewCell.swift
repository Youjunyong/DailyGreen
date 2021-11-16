//
//  EntireShopTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit

class EntireShopTableViewCell: UITableViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        titleLabel.textColor = .white
        locationLabel.font = UIFont(name: NanumFont.regular, size: 17)
        locationLabel.textColor = .white
        
        shopImageView.layer.cornerRadius = 12
        shopImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
