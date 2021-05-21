//
//  CerificationModel.swift
//  Willing
//
//  Created by Kim on 2021/05/18.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation
import UIKit

struct Certification : Codable {
    var Imgurl: String = ""
    var challengeId: String = ""
    var cheering: Array<String> = []
    var question: Array<String> = []
    var timestamp: String = ""
    
    enum CodingKeys: String, CodingKey {
        case Imgurl
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
