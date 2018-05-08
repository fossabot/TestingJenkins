//
//  HeaderTableViewCell.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/17/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//


import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var sortTextField: UITextField!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var btnBackArrow: UIButton!
    @IBOutlet weak var btnForwardArrow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
