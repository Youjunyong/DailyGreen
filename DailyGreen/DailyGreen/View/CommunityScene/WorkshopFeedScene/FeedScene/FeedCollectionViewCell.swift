//
//  FeedCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/18.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        feedImageView.layer.cornerRadius = 16
        feedImageView.contentMode = .scaleAspectFill
        
    }

}
