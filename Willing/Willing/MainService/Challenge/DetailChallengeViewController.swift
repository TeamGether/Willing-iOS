//
//  DetailChallengeViewController.swift
//  Willing
//
//  Created by Kim on 2021/05/02.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class DetailChallengeViewController: UIViewController {
    var docuID: String? = nil
    var challenge: Challenge? = nil {
        didSet {
//            print("hey", challenge)
            titleLabel.text = challenge?.title
            priceLabel.text = "\((challenge?.price)!) 원"
            termLabel.text = "\((challenge?.term)!) 주간  \((challenge?.cntPerWeek)!) 번씩"
            accountLabel.text = "\((challenge?.targetBank)!) \((challenge?.targetAccount)!)"
            
            getUserInfoByEmail(email: challenge!.UID)
        }
    }
    var userInfo: UserInfo? = nil {
        didSet {
            userNameLabel.text = userInfo?.name
            getUserImgByUrl(url: (userInfo?.profile)!)
        }
    }
    var userImg: UIImage? = nil {
        didSet {
            userImageView.image = userImg
        }
    }
    var loadingCnt: Int = 0 {
        didSet {
            if loadingCnt == certListWithImg.count {
                certificationCollectionView.reloadData()
            }
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
    
    @IBOutlet weak var certificationCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.certificationCollectionView.delegate = self
        self.certificationCollectionView.dataSource = self
        
        registCell()
        self.navigationController?.navigationBar.isHidden = false
        
        getChallengeInfoByCID(challID: docuID!)
        getCertificationListByCID(challID: docuID!)
        
        userImageView.layer.cornerRadius = 30
        forkView.layer.cornerRadius = 5
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
    
    var certificationList: Array<Certification?> = []
    var certListWithImg: Array<CertificationWithImg> = []
    
    func getCertificationListByCID(challID: String) {
        DBNetwork.getCertifications(challId: challID) { certList in
            self.certificationList = certList
            print("certilist", certList)
            //Set size
            for i in self.certificationList {
                self.certListWithImg.append(CertificationWithImg.init(certification: i, image: nil))
            }
//            for i in self.certListWithImg {
//                var cnt = 0
//                DBNetwork.getImage(url: i.certification!.Imgurl, signal: cnt) { image, signal in
//                    print("signal",signal)
//                    print("image", i.certification?.Imgurl)
//                    self.certListWithImg[signal].image = image
//                    self.loadingCnt += 1
//                }
//                cnt += 1
//                print("heycnt", cnt)
//            }
            ////
            for i in 0 ..< self.certListWithImg.count {
                let cnt = i
                DBNetwork.getImage(url: self.certListWithImg[cnt].certification!.Imgurl, signal: cnt) { image, signal in
                    print("signal",signal)
                    print("image", self.certListWithImg[cnt].certification?.Imgurl)
                    self.certListWithImg[signal].image = image
                    self.loadingCnt += 1
                }
                print("heycnt", cnt)
            }
            ////
        }
    }



}

extension DetailChallengeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return certListWithImg.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCollectionViewCell
        cell.certifiationImageView.image = certListWithImg[indexPath.row].image
        cell.layer.cornerRadius = 10
        
        print("hohoyodshfoshfeowi")
        print(certListWithImg)
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
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let edgeInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        return edgeInset
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(certListWithImg[indexPath.row])
    }
    
}
