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
    let donateName: String?
    
    func signUp(completion: @escaping(Bool) -> Void) {
        if let email = email, let pwd = pwd {
            Auth.auth().createUser(withEmail: email, password: pwd) { authResult, error in
                // ...
                if error != nil {
                    print("Error \(error) : 에러발생")
                    completion(false)
                } else {
                    if let name = self.name, let donateName = self.donateName {
                        let db = Firestore.firestore()
                        db.collection("User").document().setData([
                            "name": name, "email": email, "donateName": donateName,
                            "tobe": "", "profile": "" ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                    print("Error \(err) : 에러발생")
                                    completion(false)
                                } else {
                                    print("Document successfully written!")
                                    print("authResult : ", authResult)
                                    print("currentUser : ", Auth.auth().currentUser)
                                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                                        // ...
                                        print("mail error : ", error)
                                    }
                                    completion(true)
                                }
                        }
                    }
                }
            }
        }
        
    }
    
    func existSameName(completion: @escaping (Bool, String) -> Void) {
        let db = Firestore.firestore()
        let name = self.name!
        
        db.collection("User").whereField("name", isEqualTo: name).getDocuments(){
            (querySnapshot, err) in
            var exist = false
            var checkedNick = name
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
                exist = true
                checkedNick = ""
                break
            }
            completion(exist, checkedNick)
        }
        return
    }
    
    
    func isValidDonateName(annotLabel: UILabel) -> Bool {
        var isValid = false
        var annotStr = ""
        
        if existAvailableStrValue(value: donateName){
            isValid = true
        } else {
            annotStr = "기부명을 입력하세요"
        }
        
        if isValid == false {
            annotLabel.text = annotStr
            annotLabel.textColor = UIColor.systemRed
            annotLabel.isHidden = false
        } else { annotLabel.isHidden = true }
        
        return isValid
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
            if pwd.count >= 6 {
                isValid = true
            } else {
                annotStr = "비밀번호는 6자 이상이어야 합니다."
            }
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
        // 이메일 형식의 유효성 검사도 해야함.
        if isValid == false {
            annotLabel.text = annotStr
            annotLabel.textColor = UIColor.systemRed
            annotLabel.isHidden = false
        } else { annotLabel.isHidden = true }
        
        return isValid
    }
    
}
//
//
//
//
//
//
//
//
//
//
//
//var email: String? = ""
//var pwd: String? = ""
//extension {
//
//    func signUp(completion: @escaping(Bool) -> Void) {
//        if let email = email, let pwd = pwd {
//            Auth.auth().createUser(withEmail: email, password: pwd) { authResult, error in
//                if error != nil { completion(false) }
//                else {
//                    if let name = self.name, let donateName = self.donateName {
//                        let db = Firestore.firestore()
//                        db.collection("User").document().setData([
//                            "name": name, "email": email, "donateName": donateName, "tobe": "", "profile": "" ])
//                        { err in if let err = err { completion(false) }
//                        else {
//                            Auth.auth().currentUser?.sendEmailVerification { (error) in }
//                            completion(true)
//                            }   }   }   }   }   }   }
//
//}
//
//
