//
//  ChallengeTableViewCell.swift
//  Willing
//
//  Created by Kim on 2021/04/13.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeProgressBar: UIProgressView!
    @IBOutlet weak var challengeProgressPercent: UILabel!
    @IBOutlet weak var cellContent: UIView!
    
    @IBOutlet weak var challengeSubjectLabel: UILabel!
    @IBOutlet weak var challengeSubjectView: UIView!
    
    @IBOutlet weak var addChallengeView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.backgroundColor = UInt(0xD8EAEF).uiColor
        setContentUI()
        setBarUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
    
    func setContentUI() {
        cellContent.layer.backgroundColor = UIColor(named: "WHITE")?.cgColor
        cellContent.layer.cornerRadius = 10
        
        cellContent.layer.shadowColor = UIColor.gray.cgColor
        cellContent.layer.shadowOpacity = 0.5
        cellContent.layer.shadowOffset = CGSize.init(width: 3.0, height: 3.0)
        cellContent.layer.shadowRadius = 3
        
        challengeSubjectView.layer.cornerRadius = 3
        
    }
    
    func setBarUI() {
        challengeProgressBar.transform = CGAffineTransform(scaleX: 1, y: 5)
        
        challengeProgressBar.layer.cornerRadius = 6
        challengeProgressBar.clipsToBounds = true
        challengeProgressBar.layer.sublayers![1].cornerRadius = 6
        challengeProgressBar.subviews[1].clipsToBounds = true

    }

}
