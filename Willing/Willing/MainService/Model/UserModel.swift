//
//  UserModel.swift
//  Willing
//
//  Created by Kim on 2021/04/02.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation

struct UserInfo : Codable {
    var email: String? = nil
    var name: String? = nil
    var pwd: String? = nil
    var profileImg: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case pwd
        case profileImg
        
    }
    
}
