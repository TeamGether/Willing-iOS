//
//  MyPageViewContoller.swift
//  Willing
//
//  Created by Kim on 2021/04/08.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import Firebase

class MyPageViewContoller: UIViewController {
    
    @IBOutlet weak var vcTitleView: UIView!
    var userEmail: String = (user?.email)!
//    var userEmail: String = (user?.email)! {
//        didSet {
//            if userEmail == user?.email {
//                isMyPage = true
//            } else { isMyPage = false }
//        }
//    }
    var pageUser: UserInfo? {
        didSet {
            getChallengeList()
            showUserData()
        }
    }
    
    var isMyPage = true {
        didSet {
            setUI()
        }
    }
    
    enum Mode: String {
        case processing
        case finished
    }
    var mode = Mode.processing {
        didSet {
            setTab()
            getChallengeList()
        }
    }
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var correctProfileBtn: UIButton!
    
    @IBOutlet weak var followView: UIView!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var processingBtn: UIButton!
    @IBOutlet weak var processingUnderBar: UIView!
    @IBOutlet weak var finishedBtn: UIButton!
    @IBOutlet weak var finishedUnderBar: UIView!
    
    @IBOutlet weak var challengeList: UITableView!
    var didNotLoad = true
    var challengeSummary: Array<ChallengeSummaryUnit>? {
        didSet {
            print("didset", challengeSummary!)
            didNotLoad = false
            challengeList.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        challengeList.delegate = self
        challengeList.dataSource = self
        registChallengeListCell()
        
        setUI()
        setUserByEmail(email: userEmail)
        print("chall list ", challengeSummary)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUI() {
        print("hey")
        profileImgView.layer.cornerRadius = 25
        followView.layer.cornerRadius = 5
        setUIByIsMine()
    }
    
    func setTab() {
        switch mode {
        case .processing:
            processingBtn.setTitleColor(UIColor(named: "PRIMARY BLUE"), for: .normal)
            finishedBtn.setTitleColor(UIColor.black, for: .normal)
            processingUnderBar.isHidden = false
            finishedUnderBar.isHidden = true
            break
        case .finished:
            processingBtn.setTitleColor(UIColor.black, for: .normal)
            finishedBtn.setTitleColor(UIColor(named: "PRIMARY BLUE"), for: .normal)
            processingUnderBar.isHidden = true
            finishedUnderBar.isHidden = false
            break
        }
    }
    
    @IBOutlet weak var vcTitleLabel: UILabel!
    func setUIByIsMine() {
        switch isMyPage {
        case true:
            followView.isHidden = true
            correctProfileBtn.isHidden = false
//            vcTitleView.isHidden = false
            vcTitleLabel.text = "마이페이지"
        case false:
            followView.isHidden = false
            correctProfileBtn.isHidden = true
//            vcTitleView.isHidden = true
            vcTitleLabel.text = "프로필보기"
        }
    }
    
    func showUserData() {
        nameLabel.text = pageUser?.name
        emailLabel.text = pageUser?.email
        
        guard (pageUser?.profileImg) != nil else { return }
        DBNetwork.getImage(url: (pageUser?.profileImg)!) {
            image in
            self.profileImgView.image = image
        }
    }
    
    func setUserByEmail(email: String) {
        DBNetwork.getUserInfo(email: email) {
            userInfo in
            self.pageUser = userInfo
            
            if self.pageUser?.email == user?.email {
                self.isMyPage = true
            } else { self.isMyPage = false }
            print("pageUser : \(self.pageUser?.email)")
            print("user : \(user?.email)")
            self.setUIByIsMine()
            
        }
    }
    
    func getChallengeList() {
        let email = pageUser?.email
        let db = Firestore.firestore()
        
        switch mode {
        case .processing:
            db.collection("Challenge").whereField("uid", isEqualTo: email).whereField("didFinish", isEqualTo: false)
                .getDocuments() { [self](querySnapshot, err) in
                    if err == nil {
                        var challengeList: Array<ChallengeSummaryUnit> = []
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            print("chall sum data", data)
                            let challengeUnit = ChallengeSummaryUnit(docuID: document.documentID, title: data["title"]! as! String, percent: data["percent"]! as! Int, subject: data["subject"]! as! String)
                            challengeList.append(challengeUnit)
                        }
                        self.challengeSummary = challengeList
                    }
            }
            break
        case .finished:
            db.collection("Challenge").whereField("uid", isEqualTo: email)
            .whereField("didFinish", isEqualTo: true).getDocuments() { [self](querySnapshot, err) in
                    if err == nil {
                        var challengeList: Array<ChallengeSummaryUnit> = []
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            print("chall sum data", data)
                            let challengeUnit = ChallengeSummaryUnit(docuID: document.documentID, title: data["title"]! as! String, percent: data["percent"]! as! Int, subject: data["subject"]! as! String)
                            challengeList.append(challengeUnit)
                        }
                        self.challengeSummary = challengeList
                    }
            }
            break
        }
        

    }
    
    func registChallengeListCell() {
        let nibName = UINib(nibName: "ChallengeTableViewCell", bundle: nil)
        challengeList.register(nibName, forCellReuseIdentifier: "ChallengeCell")
    }
    
    @IBAction func processingBtnClicked(_ sender: Any) {
        mode = .processing
        print(isMyPage)
    }
    
    @IBAction func finishedBtnClicked(_ sender: Any) {
        mode = .finished
    }
    
    
}

extension MyPageViewContoller : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didNotLoad == true{
            return 0
        } else if challengeSummary == nil {
            return 1
        } else {
            print("chall count", challengeSummary?.count)
            return challengeSummary!.count
            
        }
        //        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = challengeList.dequeueReusableCell(withIdentifier: "ChallengeCell", for: indexPath) as! ChallengeTableViewCell
        
        if let challengeSummary = challengeSummary {
            cell.challengeTitleLabel.text = challengeSummary[indexPath.row].title
            cell.challengeSubjectLabel.text = challengeSummary[indexPath.row].subject
            switch challengeSummary[indexPath.row].subject {
            case "건강":
                cell.challengeSubjectView.backgroundColor = UIColor(named: "OPPRTUNITY")
                break
            case "공부":
                cell.challengeSubjectView.backgroundColor = UIColor(named: "POST")
                break
            case "기타":
                cell.challengeSubjectView.backgroundColor = UIColor(named: "ACCOUNT")
                break
            default:
                break
            }
            
            cell.challengeProgressPercent.text = String( challengeSummary[indexPath.row].percent)
            cell.challengeProgressBar.progress = Float(challengeSummary[indexPath.row].percent) / 100
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailChallengeViewController()
        vc.docuID = challengeSummary![indexPath.row].docuID
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
