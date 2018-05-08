//
//  PopUp.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/21/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//

import UIKit

protocol PopUpActionDelegate {
    func buttonPressedAction(string:String) -> String
    func btnCancelPressed(string: String)
}
class PopUp: UIView {

    var delegate: PopUpActionDelegate?
    
//    init(withDelegate delegate: PopUpActionDelegate?) {
//        self.delegate = delegate
//        super.init()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var lblIssue: UILabel!
    @IBOutlet weak var lblNumberOfFacing: UILabel!
    @IBOutlet weak var lblUpc: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubcategory: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var btnCorrected: UIButton!
    @IBOutlet weak var btnInvalid: UIButton!
    @IBOutlet weak var btnNotCorrect: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var commentsTextView: UITextView!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func btnCorrectedAction(_ sender: Any) {
        delegate?.buttonPressedAction(string: "button pressed")
    }
    @IBAction func btnNotCorrectedAction(_ sender: Any) {
    }
    
    @IBAction func btnInvalidAction(_ sender: Any) {
    }
   
    @IBAction func btnCancelAction(_ sender: Any) {
        delegate?.btnCancelPressed(string: "Cancelled")
    }
   
    @IBAction func btnSaveAction(_ sender: Any) {
    }

    }

