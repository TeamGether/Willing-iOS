//
//  MakeChallengeVC.swift
//  Willing
//
//  Created by Kim on 2021/05/13.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import DLRadioButton

class MakeChallengeVC: UIViewController {
    
    var challenge: Challenge = Challenge.init()
    
    var genre: String? = nil {
        didSet {
            if let genre = genre {
                selectGenreBtn.setTitle(genre, for: .normal)
            }
        }
    }
    var bank: String? = nil {
        didSet {
            if let bank = bank {
                selectBankBtn.setTitle(bank, for: .normal)
            }
        }
    }
    
    @IBOutlet weak var selectGenreBtn: UIButton!
    @IBOutlet weak var selectBankBtn: UIButton!
    
    @IBOutlet weak var oneWeekBtn: DLRadioButton!
    @IBOutlet weak var twoWeekBtn: DLRadioButton!
    @IBOutlet weak var threeWeekBtn: DLRadioButton!
    @IBOutlet weak var fourWeekBtn: DLRadioButton!
    
    @IBOutlet weak var oneCntBtn: DLRadioButton!
    @IBOutlet weak var twoCntBtn: DLRadioButton!
    @IBOutlet weak var threeCntBtn: DLRadioButton!
    @IBOutlet weak var fourCntBtn: DLRadioButton!
    
    @IBOutlet weak var price10000Btn: DLRadioButton!
    @IBOutlet weak var price30000Btn: DLRadioButton!
    @IBOutlet weak var price50000Btn: DLRadioButton!
    @IBOutlet weak var price70000Btn: DLRadioButton!
    @IBOutlet weak var price100000Btn: DLRadioButton!
    
    @IBOutlet weak var privateBtn: DLRadioButton!
    @IBOutlet weak var publicBtn: DLRadioButton!
    
    @IBOutlet weak var challengeTitleTxtField: UITextField!
    @IBOutlet weak var accountTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviBar()
        setBtnUI()
    }
    
    func setBtnUI() {
        selectGenreBtn.layer.addBorder([.bottom, .top, .left, .right], color: UIColor.lightGray, width: 0.8)
        selectBankBtn.layer.addBorder([.bottom, .top, .left, .right], color: UIColor.lightGray, width: 0.8)
        
        oneWeekBtn.isSelected = true
        oneWeekBtn.setTitleColor( .systemBlue , for: .selected)
        twoWeekBtn.setTitleColor( .systemBlue , for: .selected)
        threeWeekBtn.setTitleColor( .systemBlue , for: .selected)
        fourWeekBtn.setTitleColor( .systemBlue , for: .selected)
        
        oneCntBtn.isSelected = true
        oneCntBtn.setTitleColor( .systemBlue , for: .selected)
        twoCntBtn.setTitleColor( .systemBlue , for: .selected)
        threeCntBtn.setTitleColor( .systemBlue , for: .selected)
        fourCntBtn.setTitleColor( .systemBlue , for: .selected)
        
        price10000Btn.isSelected = true
        price10000Btn.setTitleColor( .systemBlue , for: .selected)
        price30000Btn.setTitleColor( .systemBlue , for: .selected)
        price50000Btn.setTitleColor( .systemBlue , for: .selected)
        price70000Btn.setTitleColor( .systemBlue , for: .selected)
        price100000Btn.setTitleColor( .systemBlue , for: .selected)
        
        publicBtn.isSelected = true
        privateBtn.setTitleColor( .systemBlue , for: .selected)
        publicBtn.setTitleColor( .systemBlue , for: .selected)
    }
    
    func setNaviBar() {
        self.navigationController?.navigationBar.isHidden = false
        let nextBtn = UIBarButtonItem(title: "시작하기", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButton(nextBtn, animated: true)
        
    }
    
    @objc func addTapped() {
        challenge.subject = genre
        challenge.title = challengeTitleTxtField.text
        if oneWeekBtn.isSelected == true { challenge.term = 1 }
        else if twoWeekBtn.isSelected == true { challenge.term = 2 }
        else if threeWeekBtn.isSelected == true { challenge.term = 3 }
        else if fourWeekBtn.isSelected == true { challenge.term = 4 }

        if oneCntBtn.isSelected == true { challenge.cntPerWeek = 1 }
        else if twoCntBtn.isSelected == true { challenge.cntPerWeek = 2 }
        else if threeCntBtn.isSelected == true { challenge.cntPerWeek = 3 }
        else if fourCntBtn.isSelected == true { challenge.cntPerWeek = 4 }
        
        if price10000Btn.isSelected == true { challenge.price = 10000 }
        else if price30000Btn.isSelected == true { challenge.price = 30000 }
        else if price50000Btn.isSelected == true { challenge.price = 50000 }
        else if price70000Btn.isSelected == true { challenge.price = 70000 }
        else if price100000Btn.isSelected == true { challenge.price = 100000 }
        challenge.targetBank = bank
        challenge.targetAccount = accountTxtField.text
        
        if privateBtn.isSelected == true { challenge.show = false }
        else if publicBtn.isSelected == true { challenge.show = true }
        
        if challenge.isValidChallenge() {
            let vc = CheckChallengeMakeVC()
            vc.challenge = challenge
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: false, completion: nil)
        } else {
            let alertController = UIAlertController(title: "", message: "모든 항목을 입력해주세요.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    @IBAction func selectGenreBtnClicked(_ sender: Any) {
        let vc = SelectGenreVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
//        print(self)
//        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func selectBankBtnClicked(_ sender: Any) {
        let vc = SelectBankVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    
}

extension MakeChallengeVC: SendGenreDataDelegate {
    func sendGenreData(data: String) {
        genre = data
    }
}

extension MakeChallengeVC: SendBankDataDelegate {
    func sendBankData(data: String) {
        bank = data
    }
}
