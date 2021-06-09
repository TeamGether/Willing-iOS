//
//  CerificationModel.swift
//  Willing
//
//  Created by Kim on 2021/05/18.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation
import UIKit

struct CertDocu {
    let docuID: String
    let certtification: Certification
}

struct Certification: Codable {
    var userName: String = ""
    var imgUrl: String = ""
    var challengeId: String = ""
    var cheering: Array<String> = []
    var question: Array<String> = []
    var timestamp: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case userName
        case imgUrl
        case challengeId
        case cheering
        case question
        case timestamp
    }
}

struct CertificationWithImg {
    var certification: Certification? = nil
    var image: UIImage? = nil
}
