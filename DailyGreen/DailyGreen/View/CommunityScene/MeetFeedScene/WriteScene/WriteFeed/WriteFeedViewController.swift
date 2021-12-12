//
//  WriteFeedViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/17.
//

import UIKit
import BSImagePicker
import Photos

class WriteFeedViewController: UIViewController {
    
    var isPhoto = false
    var isText = false
    
    lazy var writeFeedDataManager = WriteFeedDataManager()
    lazy var dimmingView = DimmingView()

    var communityName: String?
    var communityIdx: Int?
    var selecetedImage =  [UIImage]()
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var indicatorView: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButtonView: UIView!
    @IBOutlet weak var writeTextView: UITextView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var communityLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    @IBAction func submit(_ sender: Any) {
        if isPhoto, isText {
            var photos = [Data]()
            for image in selecetedImage {
                let img = image
                guard let data = img.jpegData(compressionQuality: 0.5) else{return}
                photos.append(data)
            }
            guard let caption = writeTextView.text else{return}
            let params = WriteFeedRequest(communityIdx: communityIdx!, caption: caption, photos: photos)
            writeFeedDataManager.uploadFeed(params: params, delegate: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(communityName ?? "") 글쓰기"
        configureUI()
        hideKeyboardWhenTappedBackground()
        placeholderSetting()
        configureNaviShadow()
        configureCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }
    
    func addKeyboardNotifications(){ // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil) }
    
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        
        if self.view.frame.origin.y < 0.0{
            return
        }
        
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height ?? 100))
            
            
            }
        }
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if self.view.frame.origin.y == 0.0{
            return
        }
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y += (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height ?? 100))
            }
        }
    
    
    private func configureUI(){
        indicatorView.contentMode = .scaleAspectFit
        communityLabel.font = UIFont(name: NanumFont.extraBold, size: 15)
        communityLabel.text = communityName ?? ""
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""

        titleView.backgroundColor = .dark2
        textFieldView.layer.cornerRadius = 16
        textFieldView.layer.borderColor = UIColor.dark2.cgColor
        textFieldView.layer.borderWidth = 2
        
        submitButton.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17)
        submitButton.setTitle("완료", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.titleLabel?.textColor = .white
        
        submitButtonView.layer.cornerRadius = 24
        submitButtonView.backgroundColor = .grayDisabled
    }
    
    private func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 600.0, height: 600.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            guard let res = result else{return}
            thumbnail = res
            self.selecetedImage.append(thumbnail)
        })
        return thumbnail
    }
    @objc func pickerClicked(_ sender: UIButton){
        selecetedImage =  [UIImage]()
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 5
        imagePicker.settings.theme.selectionStyle = .numbered
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.unselectOnReachingMax = true

        self.presentImagePicker(imagePicker, select: nil, deselect: nil, cancel: nil) { (assets) in
            for asset in assets{
                _ = self.getAssetThumbnail(asset: asset)
                self.isPhoto = true
                self.checkSubmitReady()
                self.indicatorView.image = UIImage(named: "pindicator1\(self.selecetedImage.count)")
                self.collectionView.reloadData()
            }
        }
    }

    @objc func removeAlert(){
        dimmingView.removeFromSuperview()
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: false)
    }
    
    private func presentDimmingView(message: String){

        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alretText = message
        view.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        dimmingView.dismissBtn.addTarget(self, action: #selector(removeAlert), for: .touchUpInside)
        
    }
    
    private func configureNaviShadow(){
        let naviShadowView : UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .dark1
            return view
        }()
        view.addSubview(naviShadowView)
        NSLayoutConstraint.activate([
            naviShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            naviShadowView.heightAnchor.constraint(equalToConstant: 1),
            naviShadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            naviShadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.isScrollEnabled = true
        self.collectionView.isPagingEnabled = true
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        let nib = UINib(nibName: "PickedImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "pickedImageCell")
    }
    
    private func checkSubmitReady(){
        if self.isText, self.isPhoto{
            submitButtonView.backgroundColor = .primary
            submitButton.titleLabel?.textColor = .black
            submitButton.setTitleColor(.black, for: .normal)
        }else{
            submitButton.titleLabel?.textColor = .white
            submitButtonView.backgroundColor = .grayDisabled
        }
    }
    
}
extension WriteFeedViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width

        return CGSize(width: screenWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / UIScreen.main.bounds.size.width)
        
        let cnt = selecetedImage.count
        if cnt < 2 {return}
        
        switch page {
        case 0:
            self.indicatorView.image = UIImage(named: "pindicator\(page + 1)\(cnt)")
        case 1:
            self.indicatorView.image = UIImage(named: "pindicator\(page + 1)\(cnt)")
        case 2:
            self.indicatorView.image = UIImage(named: "pindicator\(page + 1)\(cnt)")
        case 3:
            self.indicatorView.image = UIImage(named: "pindicator\(page + 1)\(cnt)")
        case 4:
            self.indicatorView.image = UIImage(named: "pindicator\(page + 1)\(cnt)")
        default:
            break
        }
    }
    
}

extension WriteFeedViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selecetedImage.count == 0{
            return 1
        }
        return selecetedImage.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickedImageCell", for: indexPath) as? PickedImageCollectionViewCell else {return UICollectionViewCell() }
        cell.pickButton.addTarget(self, action: #selector(pickerClicked(_:)), for: .touchUpInside)
        if selecetedImage.count > 0 {
            cell.selectedImageView.image = selecetedImage[indexPath.row]


        }
        
        return cell
    }
}

extension WriteFeedViewController: UITextViewDelegate {
    func placeholderSetting() {
        writeTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        writeTextView.text = "소감을 자유롭게 써주세요. (0/300)"
        writeTextView.textColor = UIColor.grayLongtxt
        
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.grayLongtxt {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "소감을 자유롭게 써주세요. (0/300)"
            textView.textColor = UIColor.grayLongtxt
            self.isText = false
            checkSubmitReady()
        }else{
            self.isText = true
            checkSubmitReady()
        }
    }

}
//presentDimmingView
extension WriteFeedViewController {
    func successWriteFeed(message: String){
        presentDimmingView(message: message)
        
    }
    
    func failedToWrite(message: String){
        presentDimmingView(message: message)
    }
}
