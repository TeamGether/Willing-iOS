//
//  SignUpViewController.swift
//  Willing
//
//  Created by Kim on 2021/03/30.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit
import Firebase

//var checkedNick: String? = nil

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nicknameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    @IBOutlet weak var pwdCheckTxtField: UITextField!
    @IBOutlet weak var donateNameTxtField: UITextField!
    
    @IBOutlet weak var nickAnnotLabel: UILabel!
    @IBOutlet weak var emailAnnotLabel: UILabel!
    @IBOutlet weak var pwdAnnotLabel: UILabel!
    @IBOutlet weak var pwdCheckAnnotLabel: UILabel!
    @IBOutlet weak var donateNameAnnotLabel: UILabel!
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var checkNickBtn: UIButton!
    
    var checkedNick = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTxtFieldUI(txtField: nicknameTxtField)
        setTxtFieldUI(txtField: emailTxtField)
        setTxtFieldUI(txtField: pwdTxtField)
        setTxtFieldUI(txtField: pwdCheckTxtField)
        setTxtFieldUI(txtField: donateNameTxtField)
        
        setBtnUI(btn: signUpBtn)
        setBtnUI(btn: checkNickBtn)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func nickCheckBtnClicked(_ sender: Any) {
        let nickname = nicknameTxtField.text
        let userInfo = SignUpUser(name: nickname, email: nil, pwd: nil, pwdCheck: nil, donateName: nil)
        var annotStr = ""
        var isValid = false
        
        // 빈칸 + 띄어쓰기 + 중복
        if userInfo.existName() == false {
            annotStr = "닉네임을 입력해주세요."
        } else if userInfo.containBlank(value: userInfo.name!) {
            annotStr = "닉네임에 띄어쓰기는 사용하실 수 없습니다."
        } else {
            userInfo.existSameName(completion: { exist, checkedNick in
                if exist == true {
                    annotStr = "이미 존재하는 닉네임입니다."
                    self.checkedNick = checkedNick
                } else {
                    annotStr = "사용가능한 닉네임입니다."
                    self.checkedNick = checkedNick
                    isValid = true
                }
                self.setAnnotLabelByValid(annotLabel: self.nickAnnotLabel, annotStr: annotStr, isValid: isValid)
            })
        }
        setAnnotLabelByValid(annotLabel: nickAnnotLabel, annotStr: annotStr, isValid: isValid)
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        let nickname = nicknameTxtField.text
        let email = emailTxtField.text
        let pwd = pwdTxtField.text
        let pwdcheck = pwdCheckTxtField.text
        let donateName = donateNameTxtField.text
        
        var isValid = true
        
        let userInfo = SignUpUser(name: nickname, email: email, pwd: pwd, pwdCheck: pwdcheck, donateName: donateName)
        
        if checkedNick != nickname || checkedNick == "" {
            isValid = false
            nickAnnotLabel.text = "중복확인을 해주세요."
            nickAnnotLabel.textColor = UIColor.systemRed
            nickAnnotLabel.isHidden = false
        }
        if userInfo.isValidEmail(annotLabel: emailAnnotLabel) == false { isValid = false }
        if userInfo.isValidPwd(annotLabel: pwdAnnotLabel) == false { isValid = false}
        if userInfo.isValidPwdCheck(annotLabel: pwdCheckAnnotLabel) == false { isValid = false}
        if userInfo.isValidDonateName(annotLabel: donateNameAnnotLabel) == false { isValid = false}
        
        if isValid {
            userInfo.signUp(completion: {
                didSuccecs in
                if didSuccecs == false {
                    let alertController = UIAlertController(title: "회원가입 실패", message: "회원가입이 실패되었습니다", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertController.addAction(okButton)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "회원가입 완료", message: "회원가입이 완료되었습니다. 메일을 확인하여 이메일 인증을 진행해주세요.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "확인", style: .default) { _ in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(okButton)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
        
    }
    
    func setAnnotLabelByValid(annotLabel: UILabel, annotStr: String, isValid: Bool) {
        if isValid {
            annotLabel.textColor = UIColor.systemBlue
        } else { annotLabel.textColor = UIColor.systemRed }
        
        annotLabel.text = annotStr
        annotLabel.isHidden = false
    }
    
    func setTxtFieldUI(txtField: UITextField) {
        txtField.layer.addBorder([.bottom], color: UIColor.gray, width: 1)
    }
    
    func setBtnUI(btn: UIButton) {
        btn.layer.backgroundColor = UInt(0xD9EBF0).cgColor
        btn.layer.cornerRadius = 10
        
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        btn.layer.shadowRadius = 3
    }
    
    
}
