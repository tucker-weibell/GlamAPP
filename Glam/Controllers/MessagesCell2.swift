//
//  MessagesCell2.swift
//  Glam
//
//  Created by Student on 11/18/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit

class MessagesCell2: UITableViewCell {

    @IBOutlet weak var recievedView: UIView!
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var revievedLabel: UILabel!
    @IBOutlet weak var sentLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
