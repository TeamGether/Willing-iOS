//
//  DBNetwork.swift
//  Willing
//
//  Created by Kim on 2021/04/14.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

let db = Firestore.firestore()
let storage = Storage.storage()

struct DBNetwork {

    static func checkSameData(collectionName: String, field: String, targetValue: String, completion: @escaping(Bool, String) -> Void) {
        db.collection(collectionName).whereField(field, isEqualTo: targetValue).getDocuments(){ (querySnapshot, err) in
            var exist = false
            var checkedNick = targetValue
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
                exist = true
                checkedNick = ""
                break
            }
            completion(exist, checkedNick)
        }
    }
    
    static func login(email: String, pwd: String, completion: @escaping (Int) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pwd){
            authResult, error in
            let loginUser = Auth.auth().currentUser
            if authResult == nil {
                completion(1)
            } else if loginUser?.isEmailVerified == false {
                completion(2)
            } else {
                user = loginUser
                completion(3)
            }
        }
    }
    
    
    static func signUp(signUpUser: SignUpUser,completion: @escaping(Bool) -> Void) {
        if let email = signUpUser.email, let pwd = signUpUser.pwd {
            Auth.auth().createUser(withEmail: email, password: pwd) {
                authResult, error in
                if error != nil { // 에러발생
                    completion(false)
                } else {
                    if let name = signUpUser.name, let donateName = signUpUser.donateName {
                        db.collection("User").document().setData([
                            "name": name, "email": email, "donateName": donateName,
                            "tobe": "", "profile": ""
                        ]) { err in
                            if let _ = err {
                                completion(false)
                            } else {
                                Auth.auth().currentUser?.sendEmailVerification{ error in }
                            }
                            completion(true)
                        }
                    }
                }
            }
        }
    }
    
    static func getChallegneByDocuID(docuId: String, completion: @escaping(Challenge) -> Void) {
        
        let docRef = db.collection("Challenge").document(docuId)
        
        docRef.getDocument { (document, error) in
            var chall: Challenge = Challenge.init()
            let result = Result {
                try document?.data(as: Challenge.self)
            }
            switch result {
            case .success(let challenge):
                chall = challenge!
                break
            case .failure(let err):
                print(err)
                break
            }
            completion(chall)
        }
        
    }
    
    static func registChallenge(challenge: Challenge, completion: @escaping(String?) -> Void) {
        do {
            let ref = try db.collection("Challenge").addDocument(from: challenge)
            completion(ref.documentID)
        } catch let error {
            print("Regist Challenge Error" ,error)
        }
    }
    
    static func getUserInfo(email: String, completion: @escaping(UserInfo) -> Void) {
        db.collection("User").whereField("email", isEqualTo: email).getDocuments() { (querySnapShot, err) in
            var userInfo = UserInfo.init()
            let document = querySnapShot!.documents[0]
            let result = Result {
                try document.data(as: UserInfo.self)
            }
            switch result {
            case .success(let userData):
                userInfo = userData!
                break
            case .failure(let err):
                break
            }
            completion(userInfo)
            
        }
    }
    
    static func getImage(url: String, completion: @escaping(UIImage) -> Void) {
        let storageRef = storage.reference()
        // Create a reference to the file you want to download
        let imgRef = storageRef.child(url)

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
          } else {
            // Data for "images/island.jpg" is returned
            guard let image = UIImage(data: data!) else { return }
            completion(image)
          }
        }
            
        
    }
    
    static func getCertifications(challId: String, completion: @escaping(Array<Certification>) -> Void) {
        
        db.collection("Certification").whereField("challengeId", isEqualTo: challId).order(by: "timestamp", descending: true).getDocuments() {
            (querySnapshot, err) in
            var certiList: Array<Certification> = []
            guard let querySnapshot = querySnapshot else { return }
            for document in querySnapshot.documents {
                let result = Result {
                    try document.data(as: Certification.self)
                }
                switch result {
                case .success(let certData):
                    certiList.append(certData!)
                    break
                case .failure(let err):
                    break
                }
            }
            completion(certiList)
        }
        
    }
    
    static func getFriends(email: String, completion: @escaping(Friends) -> Void) {
        db.collection("Follow").document(email).getDocument() {
            (document, error) in
            guard let document = document else { return }
            
            var friends = Friends.init()
            let result = Result {
                try document.data(as: Friends.self)
            }
            switch result {
            case .success(let friendsData):
                friends = friendsData!
                break
            case .failure(let err):
                print(err)
                break
            }
            completion(friends)
        }
    }
    
    static func getUserByName(name: String, completion: @escaping(UserInfo) -> Void) {
        db.collection("User").whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, err) in
            var user: UserInfo = UserInfo.init()
            guard (querySnapshot?.documents.count)! > 0 else { return }
            let userDocu = querySnapshot!.documents[0]
            let result = Result {
                try userDocu.data(as: UserInfo.self)
            }
            switch result {
            case .success(let userData):
                user = userData!
                break
            case .failure(let err):
                break
            }
            completion(user)
            
        }
    }
    
}
