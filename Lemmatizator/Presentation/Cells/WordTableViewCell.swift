//
//  WordTableViewCell.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/21/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    @IBOutlet weak var frequency: UILabel!
    @IBOutlet weak var wordName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
