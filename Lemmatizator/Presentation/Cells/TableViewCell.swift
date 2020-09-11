//
//  TableViewCell.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/20/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var medianWordLabel: UILabel!
    @IBOutlet weak var maxWordLabel: UILabel!
    @IBOutlet weak var minWordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
