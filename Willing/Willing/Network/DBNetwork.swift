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

let db = Firestore.firestore()

struct DBNetwork {
    //    func getDocuments(collection: String, ) -> <#return type#> {
    //        <#function body#>
    //    }
    
    func getDonateCenter() {
        
    }
    
    static func getChallegneByDocuID(docuId: String, completion: @escaping(Challenge) -> Void) {
        
        let db = Firestore.firestore()
        let docRef = db.collection("Challenge2").document(docuId)
        
        docRef.getDocument { (document, error) in
            var chall: Challenge = Challenge.init()
            let result = Result {
                try document?.data(as: Challenge.self)
            }
            switch result {
            case .success(let challenge):
                print("challenge", challenge)
                chall = challenge!
                break
            case .failure(let err):
                print(err)
                break
            }
            completion(chall)
        }
        
    }
    
    static func registChallenge(challenge: Challenge ,completion: @escaping(String?) -> Void) {
        do {
            let ref = try db.collection("Challenge2").addDocument(from: challenge)
            completion(ref.documentID)
        } catch let error {
            print("Regist Challenge Error" ,error)
        }
    }
    
    
}
