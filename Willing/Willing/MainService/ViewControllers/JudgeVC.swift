//
//  RankingViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/08.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import FirebaseUI

class JudgeVC: UIViewController {
    var certList: Array<CertDocu> = []
    
    @IBOutlet weak var judgeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        judgeTableView.delegate = self
        judgeTableView.dataSource = self
        registJudgeTableViewCell()
        
        setCertList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func registJudgeTableViewCell() {
        let nibName = UINib(nibName: "JudgeTableViewCell", bundle: nil)
        judgeTableView.register(nibName, forCellReuseIdentifier: "JudgeCell")
    }
    
    func setCertList() {
        DBNetwork.getRecentFeeds() {
            certList in
            self.certList = certList
            self.judgeTableView.reloadData()
        }
    }


}

extension JudgeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return certList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = judgeTableView.dequeueReusableCell(withIdentifier: "JudgeCell", for: indexPath) as! JudgeTableViewCell
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        
        let certDocu = certList[indexPath.section]
        cell.cert = certDocu
        
//        cell.userNameLabel.text = certDocu.certtification.userName
//        cell.certTimeLabel.text = String(certDocu.certtification.timestamp).toSimpleDateTimeString()
//        cell.cheeringLabel.text = String(certDocu.certtification.cheering.count)
//        cell.questionLabel.text = String(certDocu.certtification.question.count)
//
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        var reference = storageRef.child(certDocu.certtification.imgUrl)
//        cell.certImgView?.sd_setImage(with: reference)
        
        DBNetwork.getCertificationById(docuId: certDocu.docuID, completion: { certData in
            
            cell.userNameLabel.text = certData.userName
            cell.certTimeLabel.text = String(certData.timestamp).toSimpleDateTimeString()
            cell.cheeringLabel.text = String(certData.cheering.count)
            cell.questionLabel.text = String(certData.question.count)
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let reference = storageRef.child(certData.imgUrl)
            cell.certImgView?.sd_setImage(with: reference)
            
        })
        
        
        DBNetwork.getChallegneByDocuID(docuId: certDocu.certtification.challengeId) {
            challenge in
            cell.challengeTitleLabel.text = challenge.title
        }
        
        DBNetwork.getUserByName(name: certDocu.certtification.userName) {
            userInfo in
            guard let userImg = userInfo.profileImg else { return }
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let reference = storageRef.child(userImg)
            cell.userImgView.sd_setImage(with: reference)
        }
        
        return cell
    }
    
    
    
    
}
