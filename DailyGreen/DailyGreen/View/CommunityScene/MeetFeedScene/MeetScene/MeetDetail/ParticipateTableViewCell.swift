//
//  ParticipateTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/14.
//

import UIKit

class ParticipateTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var underView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        underView.backgroundColor = .dark2
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.cornerRadius = 22.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
