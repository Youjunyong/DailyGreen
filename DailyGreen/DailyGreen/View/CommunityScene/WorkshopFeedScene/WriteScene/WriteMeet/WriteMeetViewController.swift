//
//  WriteMeetViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/23.
//

import UIKit
import BSImagePicker
import Photos

class WriteMeetViewController: UIViewController {

    
    var writeType = 0
    var isTitle = false
    var isPhoto = false
    var isText = false
    var communityIdx: Int?
    var communityName: String?
    var titleName: String?
    var tags = [String]()
    var photos = [Data]()
    var isRegular: Int?
    var selecetedImage = [UIImage]()
    var feeType = ""

    @IBAction func submit(_ sender: Any) {
        if  submitButtonView.backgroundColor == .primary{
            let storyboard = UIStoryboard(name: "WriteDateLocationScene", bundle: nil)
            guard let VC = storyboard.instantiateViewController(withIdentifier: "WriteDateLocationVC") as? WriteDateLocationViewController else{return}
            
            VC.communityIdx = self.communityIdx
            VC.name = titleTextField.text!
            VC.tagList = tags
            VC.bio = writeTextView.text!
            VC.maxPeopleNum = Int(peopleNumTextField.text!)
            VC.feeType = feeType
            VC.fee = feeTextField.text!
            VC.kakaoChatLink = openChatLinkTextField.text!
            VC.isRegular = isRegular
            
            for image in selecetedImage{
                let img = image
                guard let data = img.jpegData(compressionQuality: 0.5) else{return}
                photos.append(data)
            }
            VC.photos = self.photos
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
       
    }
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var submitButtonLabel: UILabel!
    
    
    @IBOutlet weak var feeTextField: UITextField!
    
    @IBOutlet weak var openChatLinkTextField: UITextField!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var submitButtonView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelUnderView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleTextFieldUnderView: UIView!
    
    @IBOutlet weak var helpLabelUnderView: UIView!
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBOutlet weak var btnLabel3: UILabel!
    @IBOutlet weak var btnLabel2: UILabel!
    @IBOutlet weak var btnLabel1: UILabel!
    @IBOutlet weak var keyWordCollectionView: UICollectionView!
    @IBOutlet weak var textViewFrameView: UIView!
    @IBOutlet weak var keyWordTitleLabelUnderView: UIView!
    @IBOutlet weak var keyWordTitleLabel: UILabel!
    @IBOutlet weak var keyWordTextField: UITextField!
    
    @IBOutlet weak var divideView1: UIView!
    @IBOutlet weak var divideView2: UIView!
    @IBOutlet weak var divideView3: UIView!
    @IBOutlet weak var divideView4: UIView!
    @IBOutlet weak var divideView5: UIView!
    @IBOutlet weak var divideView6: UIView!
    @IBOutlet weak var peopleNumTextField: UITextField!
    
    @IBOutlet weak var helpLabel1: UILabel!
    @IBOutlet weak var helpLabel2: UILabel!
    
    @IBOutlet weak var openChatTitleLabel: UILabel!
    @IBOutlet weak var feeTitleLabel: UILabel!
    @IBOutlet weak var peopleTitleLabel: UILabel!
    
    @IBOutlet weak var freeImageView: UIImageView!
    
    @IBOutlet weak var freeImageView2: UIImageView!
    @IBOutlet weak var freeImageview3: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    
    @IBAction func btn1Clicked(_ sender: Any) {
        feeType = "무료"
        feeStyle()
    }
    
    @IBAction func btn2Clicked(_ sender: Any) {
        feeType = "유료"
        feeStyle()
    }
    
    @IBAction func btn3Clicked(_ sender: Any) {
        feeType = "자율기부"
        feeStyle()
        
    }
    
    @IBAction func feeDidEnd(_ sender: Any) {
        checkSubmitReady()
    }
    private func feeStyle(){
        if self.feeType == "무료"{
            freeImageView.image = UIImage(named: "selectedButton100")
            freeImageView2.image = UIImage(named: "defaultButton100")
            freeImageview3.image = UIImage(named: "defaultButton100")
        } else if self.feeType == "유료"{
            freeImageView.image = UIImage(named: "defaultButton100")
            freeImageView2.image = UIImage(named: "selectedButton100")
            freeImageview3.image = UIImage(named: "defaultButton100")
        }else if self.feeType == "자율기부"{
            freeImageView.image = UIImage(named: "defaultButton100")
            freeImageView2.image = UIImage(named: "defaultButton100")
            freeImageview3.image = UIImage(named: "selectedButton100")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        openChatLinkTextField.delegate = self
        self.hideKeyboardWhenTappedBackground()
        configureUI()
        configureKeyWordCollectionView()
        configureImageCollectionView()
        keyWordTextField.delegate = self
        
    }
    private func configureKeyWordCollectionView(){
        keyWordCollectionView.dataSource = self
        keyWordCollectionView.delegate = self
        let nib = UINib(nibName: "KeyWordCollectionViewCell", bundle: nil)
        keyWordCollectionView.register(nib, forCellWithReuseIdentifier: "keyWordCell")
        keyWordCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
    }
    private func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 600.0, height: 600.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            guard let res = result else{ return}
            thumbnail = res
            self.selecetedImage.append(thumbnail)
        })
        return thumbnail
    }
    private func checkSubmitReady(){
        if self.isText, self.isPhoto, titleTextField.text!.count > 0, peopleNumTextField.text!.count > 0, feeTextField.text!.count > 0, feeType.count > 0 , openChatLinkTextField.text!.count > 5{
            submitButtonView.backgroundColor = .primary
            submitButton.titleLabel?.textColor = .black
        }else{
            submitButton.titleLabel?.textColor = .white
            submitButtonView.backgroundColor = .grayDisabled
        }
    }
    
    @objc func pickerClicked(_ sender: UIButton){
        selecetedImage =  [UIImage]()
        let imagePicker = ImagePickerController()
        if self.titleName == "정기모임" {
            imagePicker.settings.selection.max = 5
        }else{
            imagePicker.settings.selection.max = 1
        }
        imagePicker.settings.theme.selectionStyle = .numbered
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.unselectOnReachingMax = true

        self.presentImagePicker(imagePicker, select: nil, deselect: nil, cancel: nil) { (assets) in
            for asset in assets{
                _ = self.getAssetThumbnail(asset: asset)
                self.isPhoto = true
                self.checkSubmitReady()
                self.imageCollectionView.reloadData()
            }
        }
    }
    private func configureImageCollectionView(){
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        self.imageCollectionView.isScrollEnabled = true
        self.imageCollectionView.isPagingEnabled = true
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.imageCollectionView.collectionViewLayout = flowLayout
        self.imageCollectionView.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: "PickedImageCollectionViewCell", bundle: nil)
        imageCollectionView.register(nib, forCellWithReuseIdentifier: "pickedImageCell")
    }
    
    private func configureUI(){
        btn1.setTitle("", for: .normal)
        btn2.setTitle("", for: .normal)
        btn3.setTitle("", for: .normal)
        btnLabel1.font = UIFont(name: NanumFont.extraBold, size: 17)
        btnLabel2.font = UIFont(name: NanumFont.extraBold, size: 17)
        btnLabel3.font = UIFont(name: NanumFont.extraBold, size: 17)
        submitButton.setTitle("", for: .normal)
        placeholderSetting()
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
        
        divideView1.backgroundColor = .grayGreen
        divideView2.backgroundColor = .dark2
        divideView3.backgroundColor = .grayGreen
        divideView4.backgroundColor = .dark2
        divideView5.backgroundColor = .grayGreen
        divideView6.backgroundColor = .dark2
        
        helpLabel1.textColor = .grayLongtxt
        helpLabel2.textColor = .grayLongtxt
        
        
        feeTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        openChatTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        peopleTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        
        submitButtonView.layer.cornerRadius = 24
        submitButtonView.backgroundColor = .grayDisabled
        submitButtonLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        submitButtonLabel.textColor = .white
        submitButtonView.layer.shadowColor = UIColor.black.cgColor
        submitButtonView.layer.shadowOpacity = 0.12
        submitButtonView.layer.shadowRadius = 4
        submitButtonView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    
    
}

extension WriteMeetViewController: UITextFieldDelegate {
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == keyWordTextField{
          tags.append("#" + keyWordTextField.text!)
          keyWordTextField.text = ""
          keyWordCollectionView.reloadData()
          
      } else {
          
      
    }
    return true
  }
}


extension WriteMeetViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            if selecetedImage.count == 0 {
                return 1
            }else{
                return selecetedImage.count
            }
        }
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == imageCollectionView {
            let screenWidth = UIScreen.main.bounds.width
            return CGSize(width: screenWidth, height: 200)
        }
        
        let label : UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = tags[indexPath.item]
            label.sizeToFit()
            return label
        }()
        let size = label.frame.size
    
        return CGSize(width: size.width + 75, height: size.height + 20)
    }
    
    @objc func deleteTag(_ sender: UIButton){
        let index = sender.tag - 100
        tags.remove(at: index)
        keyWordCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickedImageCell", for: indexPath) as? PickedImageCollectionViewCell else {return UICollectionViewCell() }
            cell.pickButton.addTarget(self, action: #selector(pickerClicked(_:)), for: .touchUpInside)
            if selecetedImage.count > 0 {
                cell.selectedImageView.image = selecetedImage[indexPath.row]
            }
            return cell
        }
        
        let cell = keyWordCollectionView.dequeueReusableCell(withReuseIdentifier: "keyWordCell", for: indexPath) as! KeyWordCollectionViewCell
        cell.deleteTagButton.addTarget(self, action: #selector(deleteTag(_:)), for: .touchUpInside)
        cell.deleteTagButton.tag = indexPath.row + 100
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

extension WriteMeetViewController: UITextViewDelegate {
    func placeholderSetting() {
        writeTextView.delegate = self
        writeTextView.text = "상세정보를 자유롭게 써주세요. (0/300)"
        writeTextView.textColor = UIColor.grayLongtxt
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.grayLongtxt {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "상세정보를 자유롭게 써주세요. (0/300)"
            textView.textColor = UIColor.grayLongtxt
            self.isText = false
            checkSubmitReady()
        }else{
            self.isText = true
            checkSubmitReady()
        }
    }

}


extension WriteMeetViewController {
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkSubmitReady()
    }
}
