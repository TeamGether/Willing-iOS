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

        certificationCollectionView.reloadData()
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
//            print("certilist", certList)
        }
    }
    
    @IBAction func profileImgBtnClicked(_ sender: Any) {
        guard let userEmail = userInfo?.email else { return }
        let vc = MyPageViewContoller()
        vc.userEmail = userEmail
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func forkBtnClicked(_ sender: Any) {
        let vc = MakeChallengeVC()
        vc.isFork = true
        
        vc.genre = challenge?.subject
//        vc.selectGenreBtn.setTitle(vc.genre, for: .normal)
        vc.challenge.subject = vc.genre
        
        vc.challenge.title = challenge?.title
//        vc.challengeTitleTxtField.text = challenge?.title
        
        if challenge?.term == 1 {
//            vc.oneWeekBtn.isSelected = true
            vc.challenge.term = 1
        } else if challenge?.term == 2 {
//            vc.twoWeekBtn.isSelected = true
            vc.challenge.term = 2
        } else if challenge?.term == 3 {
//            vc.threeWeekBtn.isSelected = true
            vc.challenge.term = 3
        } else if challenge?.term == 4 {
//            vc.fourWeekBtn.isSelected = true
            vc.challenge.term = 4
        }
        
        if challenge?.cntPerWeek == 1 {
//            vc.oneCntBtn.isSelected = true
            vc.challenge.cntPerWeek = 1
        } else if challenge?.cntPerWeek == 2 {
//            vc.twoCntBtn.isSelected = true
            vc.challenge.cntPerWeek = 2
        } else if challenge?.cntPerWeek == 3 {
//            vc.threeCntBtn.isSelected = true
            vc.challenge.cntPerWeek = 3
        } else if challenge?.cntPerWeek == 4 {
//            vc.fourCntBtn.isSelected = true
            vc.challenge.cntPerWeek = 4
        }
        
        if challenge?.price == 10000 {
//            vc.price10000Btn.isSelected = true
            vc.challenge.price = 10000
        } else if challenge?.price == 30000 {
//            vc.price30000Btn.isSelected = true
            vc.challenge.price = 30000
        } else if challenge?.price == 50000 {
//            vc.price50000Btn.isSelected = true
            vc.challenge.price = 50000
        } else if challenge?.price == 70000 {
//            vc.price70000Btn.isSelected = true
            vc.challenge.price = 70000
        } else if challenge?.price == 100000 {
//            vc.price100000Btn.isSelected = true
            vc.challenge.price = 100000
        }
        
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
            let cell = certificationCollectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCollectionViewCell
            if indexPath.row == 0 {
                cell.certifiationImageView.isHidden = true
                cell.addImgView.isHidden = false
                cell.layer.cornerRadius = 10
                return cell
            } else {
                cell.addImgView.isHidden = true
                cell.certifiationImageView.isHidden = false

                
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let reference = storageRef.child(certificationList[indexPath.row-1]!.certtification.imgUrl)

                cell.certifiationImageView.sd_setImage(with: reference)
                
                cell.layer.cornerRadius = 10
//                                print(certificationList)
                return cell
            }
        }
        
        let cell = certificationCollectionView.dequeueReusableCell(withReuseIdentifier: "CertificationCell", for: indexPath) as! CertificationCollectionViewCell
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child(certificationList[indexPath.row]!.certtification.imgUrl)

        cell.certifiationImageView.sd_setImage(with: reference)

        cell.layer.cornerRadius = 10
        
//        print(certificationList)
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
//                print("add cert")
                addCert()
                break
            default: //indexPath.row-1 로 접근해야함.
//                print(certificationList[indexPath.row-1])
                print(isMine)
                let cert = certificationList[indexPath.row-1]
                let vc = CertificationVC.init(cert!.docuID)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
//            print(certificationList[indexPath.row])
            print(isMine)
            let cert = certificationList[indexPath.row]
            let vc = CertificationVC.init(cert!.docuID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func addCert() {
        let vc = UIAlertController(title: "인증방식을 선택하세요", message: nil, preferredStyle: .actionSheet)
        
        var cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "취소", style: .cancel) {
            (action: UIAlertAction) in
            self.cancel()
        }
        
        var albumAction: UIAlertAction
        albumAction = UIAlertAction(title: "앨범", style: .default) {
            (action: UIAlertAction) in
            self.useAlbum()
        }
        
        var cameraAction: UIAlertAction
        cameraAction = UIAlertAction(title: "카메라", style: .default) {
            (action: UIAlertAction) in
            self.useCamera()
        }
        
        var pedometerAction: UIAlertAction
        pedometerAction = UIAlertAction(title: "만보기", style: .default) {
            (action: UIAlertAction) in
            self.usePedometer()
        }
        
        var timerAction: UIAlertAction
        timerAction = UIAlertAction(title: "타이머", style: .default) {
            (action: UIAlertAction) in
            self.useTimer()
        }
        vc.addAction(cancelAction)
        vc.addAction(albumAction)
        vc.addAction(cameraAction)
        
        vc.addAction(pedometerAction)
        vc.addAction(timerAction)
        
//        if challenge?.subject == "건강" {
//            vc.addAction(pedometerAction)
//        } else if challenge?.subject == "공부" {
//            vc.addAction(timerAction)
//        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func cancel() {
        
    }
    
    func useAlbum() {
        var selectedImage: UIImageView
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: {
            () in
        })
        
    }
    
    func useCamera() {
        var selectedImage: UIImageView
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: {
            () in
        })
    }
        
    func usePedometer() {
        
    }
    
    func useTimer() {
        let vc = TimerViewController()
        vc.challenge = challenge
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DetailChallengeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        dismiss(animated: true, completion: {
            
            // send image
            var cert = Certification()
            guard let challengeId = self.docuID else { return }
            guard let userName = self.userInfo?.name else { return }
            
            cert.challengeId = challengeId
            cert.userName = userName
            
            let now=NSDate()
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.dateFormat = "yyyyMMddHHmm"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") as Locale
            let time = dateFormatter.string(from: now as Date)
            guard let timeAsInt = Int(time) else { return }
            
            cert.timestamp = timeAsInt
            
            
            DBNetwork.enrollCertification(cert: cert, certImage: image, completion: {
                let vc = UIAlertController(title: "게시글이 등록되었습니다.", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                vc.addAction(okButton)
                self.present(vc, animated: true, completion: {
                    self.navigationController?.popViewController(animated: true)
//                    self.certificationList = []
                    self.getCertificationListByCID(challID: challengeId)
//                    self.viewDidLoad()
//                    self.certificationCollectionView.reloadData()
                    DBNetwork.updateChallengeProgressingInfo(challId: challengeId)
                    
                })
            })
            
            
        })
        
    }
    

}
