//
//  MessagesCell.swift
//  Glam
//
//  Created by Student on 11/15/20.
//  Copyright © 2020 Tucker Weibell. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var recievedView: UIView!
    @IBOutlet weak var recievedText: UILabel!
    @IBOutlet weak var sentText: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
