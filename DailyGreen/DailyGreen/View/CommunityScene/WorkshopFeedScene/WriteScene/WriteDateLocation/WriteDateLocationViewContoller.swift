//
//  WriteDateLocationViewContoller.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/25.
//

import UIKit

class WriteDateLocationViewController: UIViewController{
    
    var date = ""
    var time = ""
    var address = ""
    
    var photos = [Data]()
    var communityIdx: Int?
    var name: String?
    var tagList = [String]()
    var bio: String?
    var maxPeopleNum: Int?
    var feeType: String?
    var fee: String?
    var kakaoChatLink: String?
    var isRegular: Int?
    
    lazy var writeMeetDataManager = WriteMeetDataManager()
    
    private func postMeet(){
        
        print(address)
        print(date + " " + time)
        
        
        let params = WriteMeetRequest(photos: photos, communityIdx: communityIdx!, name: name!, tagList: tagList, bio: bio!, maxPeopleNum: maxPeopleNum ?? 3, feeType: feeType!, fee: fee!, kakaoChatLink: kakaoChatLink ?? "", isRegular: isRegular ?? 0, locationIdx: 1, locationDetail: address, when: date + " " + time)
        writeMeetDataManager.uploadFeed(params: params, delegate: self)
    }
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.cornerRadius = 5.0
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)

        return datePicker
    }()
    
    lazy var timePicker: UIDatePicker = {

        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.backgroundColor = UIColor.white
        datePicker.layer.cornerRadius = 5.0
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(onDidChangeTime(sender:)), for: .valueChanged)
        

        return datePicker
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        return view
    }()
    lazy var dimmingView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .dimming
        view.isUserInteractionEnabled = false
        return view
    }()
    lazy var setTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(setTime(_:)), for: .touchUpInside)
        return button
    }()
    lazy var setDateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(setDate(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var setDateButtonImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "setButton")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    @IBAction func setLocation(_ sender: Any) {
        
        let postCodeVC = KakaoPostCodeViewController()
        postCodeVC.delegate = self
        postCodeVC.modalPresentationStyle = .formSheet
        self.present(postCodeVC, animated: true, completion: nil)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        postMeet()
    }
    
    
    
    @IBAction func setDateClicked(_ sender: Any) {
        presentTimePicker(timeOrDate: 0)
    }
    
    @IBAction func setTimeClicked(_ sender: Any) {
        
        presentTimePicker(timeOrDate: 1)
        
    }
    @IBOutlet weak var underView1: UIView!
    
    @IBOutlet weak var submitButtonLabel: UILabel!
    @IBOutlet weak var underView2: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButtonView: UIView!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var setLocationButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var underView5: UIView!
    @IBOutlet weak var underView4: UIView!
    @IBOutlet weak var underView3: UIView!
    @IBOutlet weak var offlineButtonLabel: UILabel!
    @IBOutlet weak var onlineButtonLabel: UILabel!
    @IBOutlet weak var underView6: UIView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    private func configureUI(){
        setLocationButton.setTitle("", for: .normal)
        addressLabel.textColor = .grayDisabled
        
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        dateTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        locationTitleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        onlineButtonLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        offlineButtonLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        
        underView1.backgroundColor = .primary
        underView6.backgroundColor = .primary
        underView2.backgroundColor = .dark2
        underView3.backgroundColor = .dark2
        underView4.backgroundColor = .dark2
        underView5.backgroundColor = .dark2
        
        
        submitButton.setTitle("", for: .normal)
        submitButtonView.layer.cornerRadius = 24
        submitButtonView.backgroundColor = .grayDisabled
        submitButtonLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        submitButtonLabel.textColor = .white
        submitButtonView.layer.shadowColor = UIColor.black.cgColor
        submitButtonView.layer.shadowOpacity = 0.12
        submitButtonView.layer.shadowRadius = 4
        submitButtonView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var setDateBtn: UIButton!
    
    @IBOutlet weak var setTimeBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentAlert(title: self.feeType!)
        setTimeBtn.setTitle("", for: .normal)
        setDateBtn.setTitle("", for: .normal)
        configureUI()
        hideKeyboardWhenTappedBackground()
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
            timePicker.preferredDatePickerStyle = .wheels
        
        }
    }
    
  
    
    @objc func onDidChangeDate(sender: UIDatePicker){ // Generate the format.
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        var selectedDate: String = dateFormatter.string(from: sender.date)
        self.dateLabel.text = selectedDate

        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: sender.date)
        self.date = selectedDate
        
    }
    
    @objc func onDidChangeTime(sender: UIDatePicker){ // Generate the format.
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH시 mm분"
        
        var selectedTime: String = dateFormatter.string(from: sender.date)
        self.timeLabel.text = selectedTime

        dateFormatter.dateFormat = "HH:MM"
        selectedTime = dateFormatter.string(from: sender.date)
        self.time = selectedTime + ":00"
        
    }
    
    @objc func setDate(_ sender: UIButton){
        
        dimmingView.removeFromSuperview()
        contentView.removeFromSuperview()
        setDateButtonImageView.removeFromSuperview()
        datePicker.removeFromSuperview()
        setDateButton.removeFromSuperview()
        
    }
    @objc func setTime(_ sender: UIButton){
        
        dimmingView.removeFromSuperview()
        contentView.removeFromSuperview()
        setDateButtonImageView.removeFromSuperview()
        timePicker.removeFromSuperview()
        setDateButton.removeFromSuperview()
        
    }
    func getAddress(_ address :String ){
        self.dismiss(animated: true, completion: nil)
        addressLabel.textColor = .black
        self.address = address
        addressLabel.text = address
    }
    private func presentTimePicker(timeOrDate: Int){
        
        if timeOrDate == 0{
            view.addSubview(dimmingView)
            view.addSubview(contentView)
            view.addSubview(setDateButtonImageView)
            view.addSubview(datePicker)
            view.addSubview(setDateButton)
            NSLayoutConstraint.activate([
                datePicker.bottomAnchor.constraint(equalTo: setDateButtonImageView.topAnchor, constant: -30),
                datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                datePicker.heightAnchor.constraint(equalToConstant: 180),
                setDateButton.topAnchor.constraint(equalTo: setDateButtonImageView.topAnchor),
                setDateButton.leadingAnchor.constraint(equalTo: setDateButtonImageView.leadingAnchor),
                setDateButton.trailingAnchor.constraint(equalTo: setDateButtonImageView.trailingAnchor),
                setDateButton.bottomAnchor.constraint(equalTo: setDateButtonImageView.bottomAnchor),
                contentView.topAnchor.constraint(equalTo: datePicker.topAnchor, constant: -40),

            ])
        }else{
            view.addSubview(dimmingView)
            view.addSubview(contentView)
            view.addSubview(setDateButtonImageView)
            view.addSubview(timePicker)
            view.addSubview(setTimeButton)
            NSLayoutConstraint.activate([
                timePicker.bottomAnchor.constraint(equalTo: setDateButtonImageView.topAnchor, constant: -30),
                timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                timePicker.heightAnchor.constraint(equalToConstant: 180),
                setTimeButton.topAnchor.constraint(equalTo: setDateButtonImageView.topAnchor),
                setTimeButton.leadingAnchor.constraint(equalTo: setDateButtonImageView.leadingAnchor),
                setTimeButton.trailingAnchor.constraint(equalTo: setDateButtonImageView.trailingAnchor),
                setTimeButton.bottomAnchor.constraint(equalTo: setDateButtonImageView.bottomAnchor),
                contentView.topAnchor.constraint(equalTo: timePicker.topAnchor, constant: -40),

                
            ])
        }

        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            setDateButtonImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            setDateButtonImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            setDateButtonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            setDateButtonImageView.heightAnchor.constraint(equalToConstant: 56),
            
            
        ])
        
        
    }
}


extension WriteDateLocationViewController{
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        
        
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height - 200
            
            self.view.frame.origin.y -= keyboardHeight
            
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
            let keyboardHeight = keyboardRectangle.height - 200
            
            self.view.frame.origin.y += keyboardHeight
            
            }
        
//        if isSubmitReady() {
//            let nickName = nickNameTextField.text
//            let bio = textView.text
//
//        }
        }
    
    func addKeyboardNotifications(){ // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil) }
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension WriteDateLocationViewController{
    func successWriteMeed(message: String){
        self.presentAlert(title: message)
    }
    
    func failedToWrite(message: String){
        self.presentAlert(title: message)
    }
}
