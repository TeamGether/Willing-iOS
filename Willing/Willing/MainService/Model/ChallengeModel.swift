//
//  ChallengeModel.swift
//  Willing
//
//  Created by Kim on 2021/04/14.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation
import Firebase

struct ChallengeSummaryUnit {
    let docuID: String
    let title: String
    let percent: Int
    let subject: String
}

public struct Challenge: Codable {
    
    var UID: String = (user?.email)!
    var tobe: String? = nil
    var percent: Int = 0
    var didFinish: Bool = false
    var didSuccess: Bool = false
    
    var subject: String? = nil
    var title: String? = nil
    var term: Int = 1
    var cntPerWeek: Int = 1
    var price: Int = 10000
    var targetBank: String? = nil
    var targetAccount: String? = nil
    var show: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case UID
        case tobe
        case percent
        case didFinish
        case didSuccess
        
        case subject
        case title
        case term
        case cntPerWeek
        case price
        case targetBank
        case targetAccount
        case show
    }
    
    func isValidChallenge() -> Bool {
        if let _ = subject, let _ = title, let _ = targetBank, let _ = targetAccount {
            return true
        }
        return false
    }

    
    
    
    
}
