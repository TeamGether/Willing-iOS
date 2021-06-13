//
//  CommentModel.swift
//  Willing
//
//  Created by Kim on 2021/06/13.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation

struct CommentDocu {
    let docuId: String
    var comment: Comment
}


struct Comment : Codable {
    let userName: String
    let content: String // 내용
    
    let servertime: Int
    let timestamp: String
    
    let imgId: String // 어떤 인증게시물인지?
    let profileImg: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case content
        case servertime
        case timestamp
        case imgId
        case profileImg
    }
}
