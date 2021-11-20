//
//  ShopCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/19.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        shopImageView.contentMode = .scaleAspectFill
        // Initialization code
    }

}
