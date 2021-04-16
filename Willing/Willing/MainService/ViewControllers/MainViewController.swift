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

class MainViewController: UIViewController {
    @IBOutlet weak var addChallengeBtn: UIButton!
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

        self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
        challengeList.delegate = self
        challengeList.dataSource = self
        registChallengeListCell()
        
        getChallengeList()
        print("chall list ", challengeSummary)

    }
        
    func getChallengeList() {
        let email = user!.email!
        let db = Firestore.firestore()
        
        db.collection("Challenge").whereField("email", isEqualTo: email)
            .getDocuments() { [self](querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var challengeList: Array<ChallengeSummaryUnit> = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let challengeUnit = ChallengeSummaryUnit(title: data["title"]! as! String, percent: data["percent"]! as! Int )
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
//                let a = 11
//                cell.challengeProgressPercent.text = String(a)
                cell.challengeProgressPercent.text = String( challengeSummary[indexPath.row].percent)
                cell.challengeProgressBar.progress = Float(challengeSummary[indexPath.row].percent) / 100
            } else if indexPath.row == challengeSummary.count {
                cell.challengeTitleLabel.isHidden = true
                cell.challengeProgressPercent.isHidden = true
                cell.challengeProgressBar.isHidden = true
                cell.addChallengeView.isHidden = false
            }
        }
//        cell.challengeProgressPercent.text = challengeSummary?[indexPath.row].percent
        
//        let selectedView = UIView()
//        selectedView.backgroundColor = .clear
//        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    
}
