//
//  PostTableViewCell.swift
//  instagram
//
//  Created by Carlos Osco Huaricapcha on 3/4/16.
//  Copyright © 2016 Carlos Osco Huaricapcha. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts



class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    
    @IBOutlet weak var postCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
