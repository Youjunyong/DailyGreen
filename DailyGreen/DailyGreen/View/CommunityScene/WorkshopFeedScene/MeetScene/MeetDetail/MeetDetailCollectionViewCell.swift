//
//  MeetDetailCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/26.
//

import UIKit

class MeetDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var MeetDetailImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        MeetDetailImageView.contentMode = .scaleAspectFill
    }

}
