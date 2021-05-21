//
//  GenreTableViewCell.swift
//  Willing
//
//  Created by Kim on 2021/05/15.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    @IBOutlet weak var genreNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
