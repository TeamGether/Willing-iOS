//
//  DetailChallengeViewController.swift
//  Willing
//
//  Created by Kim on 2021/05/02.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import FirebaseUI

class DetailChallengeViewController: UIViewController {
    var isMine: Bool = false {
        didSet {
            setByMine()
            certificationCollectionView.reloadData()
        }
    }
    var docuID: String? = nil
    var challenge: Challenge? = nil {
        didSet {
            titleLabel.text = challenge?.title
            priceLabel.text = "\((challenge?.price)!) 원"
            termLabel.text = "\((challenge?.term)!) 주간  \((challenge?.cntPerWeek)!) 번씩"
            accountLabel.text = "\((challenge?.targetBank)!) \((challenge?.targetAccount)!)"
            
            getUserInfoByEmail(email: challenge!.uid)
            
            if (challenge?.uid != user?.email) {
                isMine = false
            } else { isMine = true }
        }
    }
    var userInfo: UserInfo? = nil {
        didSet {
            userNameLabel.text = userInfo?.name
            guard (userInfo?.profileImg) != nil else { return }
            getUserImgByUrl(url: (userInfo?.profileImg)!)
        }
    }
    var userImg: UIImage? = nil {
        didSet {
            userImageView.image = userImg
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var forkBtn: UIButton!
    @IBOutlet weak var forkView: UIView!
    
    @IBOutlet weak var accountTitleLabel: UILabel!
    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var certificationCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.certificationCollectionView.delegate = self
        self.certificationCollectionView.dataSource = self
        
        registCell()
        
        getChallengeInfoByCID(challID: docuID!)
        getCertificationListByCID(challID: docuID!)
        
        userImageView.layer.cornerRadius = 30
        forkView.layer.cornerRadius = 5
        setByMine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    func setByMine() {
        if isMine {
            userView.isHidden = true
            forkView.isHidden = true
            accountTitleLabel.isHidden = false
            accountLabel.isHidden = false
        } else {
            userView.isHidden = false
            forkView.isHidden = false
            accountTitleLabel.isHidden = true
            accountLabel.isHidden = true
        }
    }
    
    func registCell() {
        self.certificationCollectionView.register(UINib(nibName: "CertificationCollectionViewCell", bundle: nil) ,forCellWithReuseIdentifier: "CertificationCell")
    }
    
    func getChallengeInfoByCID(challID: String) {
        DBNetwork.getChallegneByDocuID(docuId: challID) { chall in
            self.challenge = chall
        }
    }
    
    func getUserInfoByEmail(email: String) {
        DBNetwork.getUserInfo(email: email) { userInfo in
            self.userInfo = userInfo
        }
    }
    
    func getUserImgByUrl(url: String) {
        DBNetwork.getImage(url: url) { image in
            self.userImg = image
        }
    }
    
    var certificationList: Array<CertDocu?> = [] {
        didSet {
            certificationCollectionView.reloadData()
        }
    }
    
    func getCertificationListByCID(challID: String) {
        DBNetwork.getCertifications(challId: challID) { certList in
            self.certificationList = certList
            print("certilist", certList)
        }
    }
    
    @IBAction func profileImgBtnClicked(_ sender: Any) {
        guard let userEmail = userInfo?.email else { return }
        let vc = MyPageViewContoller()
        vc.userEmail = userEmail
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension DetailChallengeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMine {
            return certificationList.count + 1
        }
        return certificationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isMine {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCollectionViewCell
            if indexPath.row == 0 {
                cell.certifiationImageView.isHidden = true
                cell.addImgView.isHidden = false
                cell.layer.cornerRadius = 10
                return cell
            } else {
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let reference = storageRef.child(certificationList[indexPath.row-1]!.certtification.imgUrl)

                cell.certifiationImageView.sd_setImage(with: reference)
                
                cell.layer.cornerRadius = 10
                                print(certificationList)
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCollectionViewCell
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child(certificationList[indexPath.row]!.certtification.imgUrl)

        cell.certifiationImageView.sd_setImage(with: reference)

        cell.layer.cornerRadius = 10
        
        print(certificationList)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellwidth = (certificationCollectionView.bounds.width - 6)/4
        let cellheight = cellwidth
        return CGSize(width: cellwidth, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isMine {
            switch indexPath.row {
            case 0:
                print("add cert")
                break
            default: //indexPath.row-1 로 접근해야함.
                print(certificationList[indexPath.row-1])
                print(isMine)
                let cert = certificationList[indexPath.row-1]
                let vc = CertificationVC.init(cert!.docuID)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            print(certificationList[indexPath.row])
            print(isMine)
            let cert = certificationList[indexPath.row]
            let vc = CertificationVC.init(cert!.docuID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
