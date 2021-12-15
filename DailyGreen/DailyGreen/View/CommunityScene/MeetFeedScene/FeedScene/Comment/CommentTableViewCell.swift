//
//  CommentTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/15.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        underView.backgroundColor = .dark2
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 22.5
        timeLabel.textColor = .systemGray
        commentLabel.numberOfLines = 2
        selectionStyle  = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
