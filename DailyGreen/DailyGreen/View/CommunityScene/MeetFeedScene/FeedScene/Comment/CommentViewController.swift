//
//  CommentViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/15.
//

import UIKit

class CommentViewController: UIViewController {
    
    lazy var commentPostDataManager = CommentPostDataManager()
    lazy var commentGetDataManager = CommentGetDataManager()
    
    
    lazy var nottingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "작성된 댓글이 없습니다!"
        label.font = UIFont(name: NanumFont.regular, size: 17)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    var profileUrls = [String]()
    var nickNames = [String]()
    var agoTimes = [String]()
    var contents = [String]()
    
    var postIdx: Int?
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextFieldView: UIView!
    @IBOutlet weak var inputContentView: UIView!
    @IBOutlet weak var divideView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func send(_ sender: Any) {
        if commentTextField.text!.count == 0 {
            return
        }
        let content = commentTextField.text!
        let params = CommentPostRequest(postIdx: self.postIdx!, content: content)
        commentPostDataManager.postComment(params, delegate: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
        configureNottingLabel()
        hideKeyboardWhenTappedBackground()
        commentGetDataManager.getComment(delegate: self, postIdx: self.postIdx!)
    }
    
    override func viewWillAppear(_ animated: Bool) { self.addKeyboardNotifications() }
    override func viewWillDisappear(_ animated: Bool) { self.removeKeyboardNotifications() }
    
    
    private func configureNottingLabel(){
        self.view.addSubview(nottingLabel)
        NSLayoutConstraint.activate([
            nottingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nottingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        nottingLabel.isHidden = true
    }
    
    private func configureUI(){
        sendButton.setTitle("", for: .normal)
        commentTextField.placeholder = "댓글 내용을 입력해주세요."
        commentTextFieldView.layer.cornerRadius = 16
        commentTextFieldView.layer.borderColor = UIColor.dark2.cgColor
        commentTextFieldView.layer.borderWidth = 2
        divideView.backgroundColor = .primary
        dismissButton.setTitle("", for: .normal)
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CommentCell")
    }
    
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nickNames.count == 0 {
            nottingLabel.isHidden = false
        }else{
            nottingLabel.isHidden = true
        }
        return nickNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentTableViewCell else{return UITableViewCell()}
        let idx = indexPath.row
        cell.nickNameLabel.text = self.nickNames[idx]
        cell.commentLabel.text =  self.contents[idx]
        cell.timeLabel.text = self.agoTimes[idx]
        cell.profileImageView.load(strUrl: self.profileUrls[idx])
        return cell
    }
    
    
}

extension CommentViewController{
    // MARK: - 키보드 노티
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.

        if self.inputViewBottomConstraint.constant < 0{
            return
        }
        
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.inputViewBottomConstraint.constant -= (keyboardHeight - self.view.safeAreaInsets.bottom)
            }
        }
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        
        if self.inputViewBottomConstraint.constant == 0{
            return
        }
        
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.inputViewBottomConstraint.constant = 0
            }
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

    func didSuccessPostComment(message: String){
        commentTextField.text = ""
        commentGetDataManager.getComment(delegate: self, postIdx: self.postIdx!)
    }
    func didSuccessGetComments(message: String, results: [Comments]){
        self.profileUrls = [String]()
        self.nickNames = [String]()
        self.agoTimes = [String]()
        self.contents = [String]()
        for result in results {
            self.nickNames.append(result.nickname)
            self.contents.append(result.content ?? "")
            self.agoTimes.append(result.agoTime)
            self.profileUrls.append(result.profilePhotoUrl)
        }
        tableView.reloadData()
    }
    
    func failedToRequest(message: String){
    }
}
