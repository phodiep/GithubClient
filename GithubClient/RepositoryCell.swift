//
//  RepositoryCell.swift
//  GithubClient
//
//  Created by Pho Diep on 1/20/15.
//  Copyright (c) 2015 Pho Diep. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet var userLabel: UILabel!
    @IBOutlet var repoNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
