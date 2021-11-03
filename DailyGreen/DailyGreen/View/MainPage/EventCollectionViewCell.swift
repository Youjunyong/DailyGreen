//
//  EventCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/02.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.backgroundColor = .gray
    }

}
