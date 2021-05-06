//
//  SelectChallengeViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/16.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class SelectChallengeViewController: UIViewController {
    @IBOutlet weak var individualBtn: UIButton!
    @IBOutlet weak var groupBtn: UIButton!
    
    var isGroup: Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        
        setBtnUI(btn: individualBtn, colorValue: 0xFFF4BA)
        setBtnUI(btn: groupBtn, colorValue: 0xDEF7BC)
        
    }
    
    @IBAction func individualBtnClick(_ sender: Any) {
        isGroup = false
        
        let vc = AddChallengeViewController()
        vc.isGroup = self.isGroup
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func groupBtnClick(_ sender: Any) {
        isGroup = true
        let vc = AddChallengeViewController()
        vc.isGroup = self.isGroup
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func setBtnUI(btn: UIButton, colorValue: UInt) {
        btn.layer.backgroundColor = UInt(colorValue).cgColor
        btn.layer.cornerRadius = 10
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        btn.layer.shadowRadius = 3
        
    }
    
    
}
