//
//  StartChallengeViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/19.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class StartChallengeViewController: UIViewController {
    var didDataSet: Bool = false
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var tobeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var totalSetLabel: UILabel!
    @IBOutlet weak var setDescriptionLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var donationLabel: UILabel!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var showLabel: UILabel!
    
    
    
    var documentId: String? = nil
    
    override func viewDidLoad() {
                super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete", style: .plain, target: self, action: #selector(completeBtnTapped))
        
        print("docuID", documentId)
        
        if didDataSet == false {
            
            DBNetwork.getChallegneByDocuID(docuId: documentId!, completion: { challenge in
                self.titleLabel.text = challenge.title
                self.reasonTextView.text = challenge.reason
                self.tobeLabel.text = challenge.tobe
                self.moneyLabel.text = String(challenge.money!) + "원"
                self.startDateLabel.text = challenge.startdate
                self.endDateLabel.text = challenge.enddate
                self.totalSetLabel.text = "총 " + String(challenge.totalset!) + "세트"
                self.setDescriptionLabel.text = "세트 당 " + String(challenge.dayperset!) + "일에 " + String(challenge.numberperset!) + "번"
                self.detailLabel.text = challenge.detail
                self.donationLabel.text = challenge.donation
                if challenge.alarm == true {
                    self.alarmLabel.text = challenge.alarmtime
                } else {
                    self.alarmLabel.text = "없음"
                }
                if challenge.show == true {
                    self.showLabel.text = "공개"
                } else {
                    self.showLabel.text = "비공개"
                }
                
                self.contentView.isHidden = false
                self.didDataSet = true
                self.viewDidLoad()
            })
        }
        
        
    }
    
    @objc func completeBtnTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
