//
//  EventCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/02.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    private func configureUI(){
        imageView.layer.cornerRadius = 16
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        dateLabel.textColor = .white
    }

}
