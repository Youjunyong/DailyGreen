//
//  SeetingTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var moreButtonImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        underView.backgroundColor = .dark2
        titleLabel.font = UIFont(name: NanumFont.regular, size: 17 )
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
