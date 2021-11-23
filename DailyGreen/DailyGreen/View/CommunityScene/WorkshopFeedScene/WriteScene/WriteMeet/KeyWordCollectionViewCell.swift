//
//  KeyWordCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/23.
//

import UIKit

class KeyWordCollectionViewCell: UICollectionViewCell {

    let tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .light1
        return view
        
        
    }()

    @IBOutlet weak var tagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagView.backgroundColor = .light1
        tagView.layer.cornerRadius = tagView.frame.height / 2
        tagLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(tagView)
        sendSubviewToBack(tagView)
        NSLayoutConstraint.activate([
            tagView.trailingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: 5),
            tagView.leadingAnchor.constraint(equalTo: tagLabel.leadingAnchor, constant: -5),
            tagView.heightAnchor.constraint(equalToConstant: 25)
        ])
        tagView.layer.cornerRadius = 15
    }

}
