//
//  MainViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/04.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import Firebase

var user: User?
var userName: String = ""

class MainViewController: UIViewController {
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
        
        getChallengeList()
        print("chall list ", challengeSummary)
        
        DBNetwork.getUserInfo(email: (user?.email)!, completion: {
            userData in
            userName = userData.name!
        })

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func getChallengeList() {
        let email = user!.email!
        let db = Firestore.firestore()
        db.collection("Challenge").whereField("uid", isEqualTo: email)
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
    }
    
    func registChallengeListCell() {
        let nibName = UINib(nibName: "ChallengeTableViewCell", bundle: nil)
        challengeList.register(nibName, forCellReuseIdentifier: "ChallengeCell")
    }
    
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didNotLoad == true{
            return 0
        } else if challengeSummary == nil {
            return 1
        } else {
            print("chall count", challengeSummary?.count)
            return challengeSummary!.count + 1
            
        }
        //        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = challengeList.dequeueReusableCell(withIdentifier: "ChallengeCell", for: indexPath) as! ChallengeTableViewCell
        
        if let challengeSummary = challengeSummary {
            if indexPath.row < challengeSummary.count {
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
            } else if indexPath.row == challengeSummary.count {
                cell.challengeTitleLabel.isHidden = true
                cell.challengeProgressPercent.isHidden = true
                cell.challengeProgressBar.isHidden = true
                cell.challengeSubjectView.isHidden = true
                cell.addChallengeView.isHidden = false
            }
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case challengeList.numberOfRows(inSection: 0) - 1:
            print("clicked")
            let vc = MakeChallengeVC()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            let vc = DetailChallengeViewController()
            vc.docuID = challengeSummary![indexPath.row].docuID
            self.navigationController?.pushViewController(vc, animated: true)
            break
        }
    }
    
}
