//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Shimaa Badawy on 9/26/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellLable: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = cellView.frame.height / 5
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
