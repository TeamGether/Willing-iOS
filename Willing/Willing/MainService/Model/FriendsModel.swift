//
//  FriendsModel.swift
//  Willing
//
//  Created by Kim on 2021/05/21.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation

struct Friends :Codable {
    var follower: Array<String> = []
    var following: Array<String> = []
    
    enum CodingKeys: String, CodingKey {
        case follower
        case following
    }
}
