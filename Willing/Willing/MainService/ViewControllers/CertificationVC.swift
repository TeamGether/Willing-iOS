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
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        registCell()

        getCert()
        profileImgView.layer.cornerRadius = 25
    }
    
    func registCell() {
        commentTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
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
            print("before get comment")
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
    
    var commentList: Array<CommentDocu> = [] {
        didSet {
            commentTableView.reloadData()
        }
    }
    
    func getComment() {
        DBNetwork.getComments(certImg: certification!.imgUrl) { commentDocuList in
            print("comment docu list : ", commentDocuList)
            self.commentList = commentDocuList
        }
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
        print(vc)
//        vc.loadView()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var imageView: UIView!
    var commentMode: Bool = false
    @IBOutlet weak var commentBtn: UIButton!
    @IBAction func commentBtnClicked(_ sender: Any) {
        if commentMode == true {
            userView.isHidden = false
            imageView.isHidden = false
            commentBtn.setTitle("▹ 댓글", for: .normal)
            mainScrollView.isScrollEnabled = true
            commentMode = false
        } else {
            userView.isHidden = true
            imageView.isHidden = true
            commentBtn.setTitle("▿ 댓글", for: .normal)
            mainScrollView.isScrollEnabled = false
            commentMode = true
        }
    }
}

extension CertificationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        
        let commentDocu = commentList[indexPath.row]
        
        cell.userNameLabel.text = commentDocu.comment.userName
        cell.dateTimeLabel.text = commentDocu.comment.timestamp
        cell.contentTextView.text = commentDocu.comment.content
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child(commentDocu.comment.profileImg)
        cell.userImgview.sd_setImage(with: reference)
        
        return cell
    }
    
    
}
