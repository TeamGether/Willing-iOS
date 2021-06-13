//
//  JudgeTableViewCell.swift
//  Willing
//
//  Created by Kim on 2021/06/09.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class JudgeTableViewCell: UITableViewCell {
    
    var cert: CertDocu? = nil
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var challengeTitleLabel: UILabel!
    
    @IBOutlet weak var certTimeLabel: UILabel!
    @IBOutlet weak var certImgView: UIImageView!
    
    @IBOutlet weak var cheeringBtn: UIButton!
    @IBOutlet weak var questionBtn: UIButton!
    
    @IBOutlet weak var cheeringLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cheeringBtn.layer.cornerRadius = 8
        questionBtn.layer.cornerRadius = 8
        userImgView.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cheeringBtnClicked(_ sender: Any) {
        if let _ = cert?.certtification.cheering.firstIndex(of: userName) {
            
        } else {
            cert?.certtification.cheering.append(userName)
            DBNetwork.correctCertification(certId: cert!.docuID, cert: cert!.certtification){ [self] in
                cheeringLabel.text = String(Int(cheeringLabel.text!)! + 1)
            }
        }
        
    }
    
    @IBAction func questionBtnClicked(_ sender: Any) {
        if let _ = cert?.certtification.question.firstIndex(of: userName) {
            
        } else {
            cert?.certtification.question.append(userName)
            DBNetwork.correctCertification(certId: cert!.docuID, cert: cert!.certtification){ [self] in
                questionLabel.text = String(Int(questionLabel.text!)! + 1)

            }
        }
    
    }
    
    
}
