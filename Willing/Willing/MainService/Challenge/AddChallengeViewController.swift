//
//  AddChallengeViewController.swift
//  Willing
//
//  Created by Kim on 2021/04/17.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class AddChallengeViewController: UIViewController {
    var isGroup: Bool? = nil
    
    @IBOutlet weak var titleHighlight: UIView!
    @IBOutlet weak var reasonHighlight: UIView!
    @IBOutlet weak var tobeHightlight: UIView!
    @IBOutlet weak var friendsHighlight: UIView!
    
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var tobeTxtField: UITextField!
    @IBOutlet weak var friendsTxtField: UITextField!
    
    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBOutlet weak var friendsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()

        
    }

    func setUI() {
        setHightLightUI(highlightView: titleHighlight)
        setHightLightUI(highlightView: reasonHighlight)
        setHightLightUI(highlightView: tobeHightlight)
        setHightLightUI(highlightView: friendsHighlight)
        
        setUnderBar(view: titleTxtField)
        setUnderBar(view: tobeTxtField)
        setUnderBar(view: friendsTxtField)
        
        setTextViewUI(txtView: reasonTextView)
        
        if let isGroup = isGroup {
            if !(isGroup) {
                friendsView.isHidden = true
            }
        }
        
        let nextBtn = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButton(nextBtn, animated: true)
        
    }

    @objc func addTapped() {
        let challenge: Challenge
        challenge = Challenge.init(isgroup: self.isGroup!, gid: nil, title: titleTxtField.text, reason: reasonTextView.text, tobe: tobeTxtField.text)
        
        let vc = DescribeChallengeViewController()
        vc.challenge = challenge
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setHightLightUI(highlightView: UIView) {
        highlightView.layer.cornerRadius = 10
    }
    
    func setUnderBar(view: UIView) {
        view.layer.addBorder([.bottom], color: UIColor.lightGray, width: 1)
    }
    
    func setTextViewUI(txtView: UITextView) {
        txtView.layer.borderWidth = 1
        txtView.layer.borderColor = UIColor.lightGray.cgColor
        txtView.layer.cornerRadius = 10
    }

}

