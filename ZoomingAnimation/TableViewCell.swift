//
//  TableViewCell.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/14/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblUPC: UILabel!
    @IBOutlet weak var lblAction: UILabel!
    @IBOutlet weak var lblPostion: UILabel!
    @IBOutlet weak var lblName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
