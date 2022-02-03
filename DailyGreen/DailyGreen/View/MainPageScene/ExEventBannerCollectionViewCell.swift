//
//  ExEventBannerCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2022/02/02.
//

import UIKit

class ExEventBannerCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var exEventButton: UIButton!
    @IBOutlet weak var exEventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        exEventButton.setTitle("", for: .normal)
        
        
        
    }

    
}
