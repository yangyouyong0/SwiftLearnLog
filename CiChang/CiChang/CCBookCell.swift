//
//  CCBookCell.swift
//  CiChang
//
//  Created by yangyouyong on 15/7/8.
//  Copyright © 2015年 yangyouyong. All rights reserved.
//

import UIKit

class CCBookCell: UITableViewCell {

    //MARK:Properties
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var learnCount: UILabel!
   
    @IBOutlet weak var wordCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
