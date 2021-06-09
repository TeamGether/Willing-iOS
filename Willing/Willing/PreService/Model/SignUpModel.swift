//
//  SignUpModel.swift
//  Willing
//
//  Created by Kim on 2021/04/02.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation
import Firebase

struct SignUpUser {
    let name: String?
    let email: String?
    let pwd: String?
    let pwdCheck: String?
    
    func existSameName(completion: @escaping (Bool, String) -> Void) {
        let name = self.name!
        DBNetwork.checkSameData(collectionName: "User", field: "name", targetValue: name, completion: completion)
    }
    
    
    func isValidPwdCheck(annotLabel: UILabel) -> Bool {
        var isValid = false
        var annotStr = ""
        
        if pwd == pwdCheck {
            isValid = true
        } else {
            annotStr = "비밀번호와 같아야합니다."
        }
        
        if isValid == false {
            annotLabel.text = annotStr
            annotLabel.textColor = UIColor.systemRed
            annotLabel.isHidden = false
        } else { annotLabel.isHidden = true }
        
        return isValid
        
    }
    
    
    func isValidPwd(annotLabel: UILabel) -> Bool {
        var isValid = false
        var annotStr = ""
        
        if let pwd = pwd {
            if pwd.count >= 6 { isValid = true }
            else { annotStr = "비밀번호는 6자 이상이어야 합니다." }
        }
        if isValid == false {
            annotLabel.text = annotStr
            annotLabel.textColor = UIColor.systemRed
            annotLabel.isHidden = false
        } else { annotLabel.isHidden = true }
        
        return isValid
    }
    
    
    func containBlank(value: String) -> Bool {
        for i in value {
            if i == " " { return true }
        }
        return false
    }
    
    
    func existName() -> Bool {
        return existAvailableStrValue(value: name)
    }
    
    
    private func existAvailableStrValue(value :String?) -> Bool {
        if value! == "" || value == nil { return false }
        return true
    }
    
    func isValidEmail(annotLabel :UILabel) -> Bool {
        var annotStr = ""
        var isValid = true
        if email! == "" || email == nil {
            annotStr = "이메일을 입력하세요."
            isValid = false
        } else if containBlank(value: email!) {
            annotStr = "유효한 이메일을 입력하세요."
            isValid = false
        }
        if isValid == false {
            annotLabel.text = annotStr
            annotLabel.textColor = UIColor.systemRed
            annotLabel.isHidden = false
        } else { annotLabel.isHidden = true }
        
        return isValid
    }
    
}
