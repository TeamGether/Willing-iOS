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
    let title: String
    let percent: Int
}

public struct Challenge: Codable {
    var nickname = user?.email
    var isgroup: Bool = false
    var gid: String? = nil
    
    var title: String? = nil
    var reason: String? = nil
    var tobe: String? = nil
    var friends: Array<String?> = []
    
    var money: Int? = nil
    var startdate: String? = nil
    var totalset: Int? = nil
    var dayperset: Int? = nil
    var numberperset: Int? = nil
    var enddate: String? = ""
    var detail: String? = nil
    
    var donation: String? = nil
    
    var alarm: Bool = true
    var alarmday: Array<String>? = []
    var alarmtime: String? = nil
    
    var show: Bool = true
    
    var success: Bool = false
    var percentage: Int = 0
    var finish: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case isgroup
        case gid
        case title
        case reason
        case tobe
        case friends
        case money
        case startdate
        case totalset
        case dayperset
        case numberperset
        case enddate
        case detail
        case donation
        case alarm
        case alarmday
        case alarmtime
        case show
        case success
        case percentage
        case finish
        
    }
    
    func setEndDate() {
        
    }
    
    
    
    
}
