//
//  WriteMeetViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/23.
//

import UIKit

class WriteMeetViewController: UIViewController {
    
    var communityIdx: Int?
    var communityName: String?
    var titleName: String?
    var pretag: UIView? = nil
    var tags = [String]()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelUnderView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleTextFieldUnderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var helpLabelUnderView: UIView!
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var keyWordCollectionView: UICollectionView!
    @IBOutlet weak var textViewFrameView: UIView!
    @IBOutlet weak var keyWordTitleLabelUnderView: UIView!
    @IBOutlet weak var keyWordTitleLabel: UILabel!
    
    @IBOutlet weak var keyWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedBackground()
        configureUI()
        configureKeyWordCollectionView()
        keyWordTextField.delegate = self
        
    }
    private func configureKeyWordCollectionView(){
        keyWordCollectionView.dataSource = self
        keyWordCollectionView.delegate = self
        let nib = UINib(nibName: "KeyWordCollectionViewCell", bundle: nil)
        keyWordCollectionView.register(nib, forCellWithReuseIdentifier: "keyWordCell")
        
        
        keyWordCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = keyWordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
          }
    }
    
    private func configureUI(){
        titleLabel.text = "어떤 \(titleName!)을 개최하시겠어요?"
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)

        helpLabel.font = UIFont.systemFont(ofSize: 15)
        helpLabel.textColor = .grayLongtxt
        keyWordTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        
        textViewFrameView.layer.borderColor = UIColor.dark2.cgColor
        textViewFrameView.layer.cornerRadius = 16
        textViewFrameView.layer.borderWidth = 2
        
        titleLabelUnderView.backgroundColor = .primary
        titleTextFieldUnderView.backgroundColor = .dark2
        helpLabelUnderView.backgroundColor = .grayGreen
        keyWordTitleLabelUnderView.backgroundColor = .dark2
    }

    
}

extension WriteMeetViewController: UITextFieldDelegate {
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == keyWordTextField{
          tags.append("#" + keyWordTextField.text!)
          keyWordTextField.text = ""
          keyWordCollectionView.reloadData()
          print(tags)
      } else {
          
      
    }
    return true
  }
}


extension WriteMeetViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let label : UILabel = {
//            let label = UILabel()
//            label.font = UIFont.systemFont(ofSize: 13)
//            label.text = tags[indexPath.item]
//            label.sizeToFit()
//            return label
//        }()
//        let size = label.frame.size
//        print(size)
//        return CGSize(width: size.width + 25, height: size.height + 20)
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = keyWordCollectionView.dequeueReusableCell(withReuseIdentifier: "keyWordCell", for: indexPath) as! KeyWordCollectionViewCell
        
        cell.tagLabel.text = tags[indexPath.item]
        return cell
    }
}

class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 10
 
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
 
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
