//
//  GuideViewContorller.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit
import SafariServices
class GuideViewController: UIViewController{
    
    // MARK: - DumpDataSet
    let titleArr = ["플로깅", "제로웨이스트", "분리배출", "비건레시피", "에너지,물절약", "업사이클링", "차없이 가기", "환경문화"]
    let subTitleArr = ["운동을 좋아하는 그린이에게 추천!", "일상 속에서 계속 나오는 쓰레기에 진절머리가 난 그린이에게 추천! ", "내가 버린 쓰레기가 재탄생 되는 것을 보고 싶은 그린이에게 추천!" , "건강을 생각하고 동물이 아프지 않는 요리를 먹고 싶은 그린이에게 추천!" ,"환경보호를 하면서 생활비를 같이 절약하고 싶은 그린이에게 추천!", "버려지는 물건에 새로운 가치를 주어 재활용하고 싶은 그린이에게 추천!", "산책을 좋아하는 그린이에게 추천!","여러 환경적 이슈를 더 알고 싶어하는 그린이에게 추천! "]
    let imageArr = ["grid00", "grid01" , "grid02" , "grid10", "grid12", "grid20", "grid21", "grid22"]
    let bodyArr = [
                    "플로깅은 조깅을 하면서 쓰레기를 줍는 환경보호 활동입니다. 일반 조깅보다 운동효과가 높다고 하네요! 여러 사람들과 같이 하면 더욱 재밌습니다. 열심히 운동을 하며 주운 쓰레기를 마지막에 분리배출해서 버리면 끝!",
                    
                   "모든 제품을 재사용하고 쓰레기의 배출을 최소화하고자 하는 친환경 실천입니다. 일회용품을 쓰지 않으려 하는 노력은 좋은 출발입니다! 항상 텀블러를 가방 안에 넣고 다니는 것부터 시작해 보세요.",
                    
                   "쓰레기를 잘 분류를 하여 재활용 수거함에 버려보세요! 라벨 같이 재질이 다른 부분이 있다면 분리시켜 주시고 깨끗하게 씻어서 분리배출을 합니다. 너무 복잡하다구요? 도움말은 여기를 참고해보세요! ",
                    
                   "다양한 단계의 채식주의 음식에 도전해보세요! 일주일에 하루만 고기를 먹지 않아도 1년에 약 560km의 운전 거리에 해당하는 탄소배출을 절감할 수 있어요! 나만의 맛있는 채식주의 음식을 만들고 레시피를 공유해보세요.",
                    
                   "일상속에서 에너지 낭비와 물소비 낭비를 줄여보세요. 서울시에 사는 경우엔 '서울시 에코마일리지'를, 그 외 지역에 산다면 '탄소포인트제'에 가입하여 에너지,물절약에 대한 인센티브를 받을 수도 있어요!",
                    
                   "다양한 업사이클링 제품을 구매할 수도 있지만 직접 나만의 업사이클링 제품을 만들 수도 있습니다! 여러 업사이클링 이벤트에 참여하여서 다른 멤버들과 버려지는 물건의 새로운 모습들을 발견해보세요!",
                    
                   "근거리는 자동차 없이 가보는 건 어떤가요? 자전거,도보 모두 좋습니다. 거리가 먼 경우에는 대중교통을 이용하는 것도 좋은 방법입니다! 매연을 뿜는 자동차 없이 가기는 이산화 탄소 배출을 줄이는 가장 좋은 방법 중 하나입니다!",
                    
                   "환경에 관심을 갖기 시작했지만 깊게 잘 알지 못한다구요? 다양한 환경적 이슈를 공부하고 공유하는 문화생활에 참여해보세요. 환경적 이슈에서 출발하여 사회문화적인 이슈까지 넓은 스펙트럼에서 환경 라이프에 대해 함께 이야기 나눠봐요."
    ]
    
    var linkedLabel: UILabel?
    var expandedCellArr = [Int]()
    
    
    @IBOutlet weak var headerView: ModalHeaderView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "GuideTableViewCell", bundle: nil)
        tableView.register(nib , forCellReuseIdentifier: "guideCell")
        tableView.separatorStyle = .none
        
    }
    
    private func configureUI(){
        headerView.titleLabel.text = "커뮤니티 가이드"
        headerView.dismissButton.addTarget(self, action: #selector(dismissGuide(_:)), for: .touchUpInside)
        infoLabel.font = UIFont(name: NanumFont.regular, size: 13)
        infoLabel.textColor = UIColor.grayLongtxt
        
        
        let attrString = NSMutableAttributedString(string: infoLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        infoLabel.attributedText = attrString
    }
    //
    
    @objc func expandCell(_ sender: UIButton) {
        
        let rowIdx = sender.tag
        if expandedCellArr.contains(rowIdx) {
            guard let arrIdx = expandedCellArr.firstIndex(of: rowIdx) else{return}
            expandedCellArr.remove(at: arrIdx)
        }else{
            expandedCellArr.append(rowIdx)
        }
        let indexPath = NSIndexPath(row: rowIdx, section: 0) as IndexPath
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .fade )
        self.tableView.endUpdates()
        

   }
    //
    @objc func dismissGuide(_ sender: UIButton){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

    
}
extension GuideViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bodyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "guideCell") as? GuideTableViewCell else{return UITableViewCell()}
    
        if expandedCellArr.contains(indexPath.row){
            cell.btn.setImage(UIImage(named: "ic-Rdropdown"), for: .normal)
        }else{
            cell.btn.setImage(UIImage(named: "ic-dropdown"), for: .normal)
        }
        cell.titleLabel.text = titleArr[indexPath.row]
        cell.subTitleLabel.text = subTitleArr[indexPath.row]
        cell.imgView.image = UIImage(named: imageArr[indexPath.row])
        
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(expandCell(_:)), for: .touchUpInside)
        cell.bodyLabel.text = bodyArr[indexPath.row]
        
        if indexPath.row == 2 {
            let attrString = NSMutableAttributedString(string: cell.bodyLabel.text!)
            cell.bodyLabel.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(
              target: self,
              action: #selector(fixedLabelTapped(_:))
            )
            cell.bodyLabel.addGestureRecognizer(recognizer)
            
            attrString.addAttribute(.font, value: UIFont(name: NanumFont.extraBold, size: 13)!, range: (cell.bodyLabel.text! as NSString).range(of: "여기"))
            attrString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (cell.bodyLabel.text! as NSString).range(of: "여기"))
            cell.bodyLabel.attributedText = attrString
            linkedLabel = cell.bodyLabel
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if   expandedCellArr.contains(indexPath.row) {
            return 220
        }else{
            return 100
        }
    }
    
    @objc func fixedLabelTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
        
        guard let label:UILabel = self.linkedLabel else {return}
        //fixedLabel에서 UITapGestureRecognizer로 선택된 부분의 CGPoint를 구합니다.
        let point = sender.location(in: linkedLabel)
        
        // fixedLabel 내에서 문자열 google이 차지하는 CGRect값을 구해, 그 안에 point가 포함되는지를 판단합니다.
        if let googleRect = label.boundingRectForCharacterRange(subText: "여기"),
                            googleRect.contains(point) {
            present(url: "https://url.kr/vtofwz")
        }
        
    }
    
    func present(url string: String) {
      if let url = URL(string: string) {
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
      }
    }
    
}
