//
//  MyPageTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/24.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var openerImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dismissButton.setTitle("", for: .normal)
        frameView.layer.borderColor = UIColor.primary.cgColor
        frameView.layer.cornerRadius = 12
        frameView.layer.borderWidth = 1
        categoryView.layer.cornerRadius = 15
        categoryView.backgroundColor = .light1
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        dateLabel.font = UIFont(name: NanumFont.regular, size: 13)
        locationLabel.font = UIFont(name: NanumFont.regular, size: 13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
