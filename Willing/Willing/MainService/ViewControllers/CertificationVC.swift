//
//  CertificationVC.swift
//  Willing
//
//  Created by Kim on 2021/05/30.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import FirebaseUI

class CertificationVC: UIViewController {
    var certId: String?
    var certification: Certification? = nil
    var certUser: UserInfo? = nil
    
    init(_ certId: String) {
        super.init(nibName: nil, bundle: nil)
        self.certId = certId
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.certId = nil
    }
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var certTimeLabel: UILabel!
    @IBOutlet weak var certImgView: UIImageView!
    @IBOutlet weak var challTitle: UILabel!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCert()
        profileImgView.layer.cornerRadius = 25
    }

    func getCert() {
        DBNetwork.getCertificationById(docuId: certId!) { cert in
            self.certification = cert
            self.certTimeLabel.text = String(cert.timestamp).toDateString()
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let reference = storageRef.child(cert.imgUrl)
            self.certImgView.sd_setImage(with: reference)
            
            guard let userName = self.certification?.userName else { return }
            self.getUser(userName: userName)
            self.getChallenge(challId: cert.challengeId)
            self.getComment()
            
        }
    }
    
    func getUser(userName: String) {
        DBNetwork.getUserByName(name: userName) { userInfo in
            self.certUser = userInfo
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let reference = storageRef.child(userInfo.profileImg!)

            self.profileImgView.sd_setImage(with: reference)
            self.userNameLabel.text = userInfo.name
        }
    }
    
    func getComment() {
        
    }
    
    func getChallenge(challId: String) {
        DBNetwork.getChallegneByDocuID(docuId: challId) { chall in
            self.challTitle.text = chall.title
        }
    }
    
    @IBAction func profileImgBtnClicked(_ sender: Any) {
        guard let userEmail = certUser?.email else { return }
        let vc = MyPageViewContoller()
        vc.userEmail = userEmail
//        vc.loadView()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
