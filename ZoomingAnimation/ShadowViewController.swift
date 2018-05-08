//
//  ShadowViewController.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/13/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//

import UIKit

class ShadowViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var shadowLabel: UILabel!
    @IBOutlet weak var searchBae: UISearchBar!
    @IBOutlet weak var lblRandD: UILabel!
    @IBOutlet weak var textFieldRandD: UITextField!
    
    let dropDownImageView = UIImageView()
    let dropDownView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadowView.layer.shadowRadius = 20
        
        shadowLabel.layer.shadowColor = UIColor.green.cgColor
        shadowLabel.layer.shadowOpacity = 1
        shadowLabel.layer.shadowOffset = CGSize.zero
        shadowLabel.layer.shadowRadius = 30
        
        //shadowLabel.shadowColor = UIColor.blue
        
       searchBae.setImage(UIImage(named: "Full Moon Filled-50"), for: .search, state: .normal)
        searchBae.setPositionAdjustment(UIOffset.init(horizontal: 20, vertical: 20), for: UISearchBarIcon.search)
        
        let textFieldInsideSearchBar = searchBae.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor(red: 15.0, green: 142.0, blue: 187.0, alpha: 1.0)
        
        lblRandD.backgroundColor = UIColor(red: 15.0/255.0, green: 142.0/255.0, blue: 187.0/255.0, alpha: 1.0)
        
       
        dropDownImageView.image = UIImage(named: "Full Moon Filled-50")
        dropDownView.addSubview(dropDownImageView)
        
        dropDownView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        dropDownImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        textFieldRandD.rightViewMode = UITextFieldViewMode.always
        textFieldRandD.rightView = dropDownView
        
        
        lblRandD.font = UIFont.italicSystemFont(ofSize: 14.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
