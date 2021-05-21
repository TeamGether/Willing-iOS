//
//  CheckChallengeMakeVC.swift
//  Willing
//
//  Created by Kim on 2021/05/13.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class CheckChallengeMakeVC: UIViewController {
    var challenge: Challenge = Challenge.init()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        titleLabel.text = challenge.title
        moneyLabel.text = String(challenge.price) + " 원"
        termLabel.text = String(challenge.term) + " 주간  " + String(challenge.cntPerWeek) + " 번씩"
        accountLabel.text = challenge.targetAccount
    }

    @IBAction func startBtnClicked(_ sender: Any) {
        DBNetwork.registChallenge(challenge: challenge) {
            documentID in
            let alertController = UIAlertController(title: "", message: "챌린지 개설이 완료되었습니다.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default, handler: {
                (UIAlertAction) -> Void in
                self.navigationController?.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }



}
