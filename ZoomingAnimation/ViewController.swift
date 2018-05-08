//
//  ViewController.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/9/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource,PopUpActionDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainImage: UIImageView!
    
    
    // property initialization global to class
    var mainImageUrl:String!
    var dataArray = [ModelClass]()
    var clickedObject :ModelClass?
    var is_searching = false
    var is_productSearch = false
    var searchingDataArray = [ModelClass]()
    var picker = UIPickerView()
    var pickerArray = ["Placement","Product"]
    var selectedBy:String?
    
    var searchTableView: UITableView = UITableView()
    var tableArray = ["Placement","Product","name","upc","action","position"]
    var sortTableView: UITableView = UITableView()
    var sortTableArray = ["Product","Placement"]
    var sortTextFieldText:String?
    var displayView: UIView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // confirming protocols using delegates to the class
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
    
       
        
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCell")
        
        parsing() // calling networking method
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btn1Action(_ sender: Any) {
    }
    
    @IBAction func btn2Action(_ sender: Any) {
    }
    
    @IBAction func btn3Action(_ sender: Any) {
    }
    
    @IBAction func btn4Action(_ sender: Any) {
    }
    @IBAction func btnActionComplaints(_ sender: Any) {
    }
    
    
    func AddSearchTableView() {
        let high = (44) * ((dataArray.count))
        searchTableView.frame =  CGRect(x: searchBar.frame.origin.x, y: (searchBar.frame.origin.y) + (searchBar.frame.height), width: searchBar.frame.width, height: CGFloat(high))
        searchTableView.backgroundColor = UIColor.clear
        searchTableView.delegate = self
        searchTableView.dataSource = self
        UIView.animate(withDuration: 10.0, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {self.view.addSubview(self.searchTableView)}, completion: nil)
    }
    
    func AddSortTableView() {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTableViewCell
        
        let high = (24) * ((sortTableArray.count))
        sortTableView.frame =  CGRect(x: header.sortTextField.frame.origin.x, y: (header.sortTextField.frame.origin.y) + (header.sortTextField.frame.height) , width: header.sortTextField.frame.width, height: CGFloat(high))
        print(sortTableView.frame)
        sortTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SortCell")
        sortTableView.backgroundColor = UIColor.clear
        sortTableView.delegate = self
        sortTableView.dataSource = self
        UIView.animate(withDuration: 10.0, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
            self.tableView.addSubview(self.sortTableView)}, completion: { finished in self.tableView.reloadData()})
    }
    
    
    //MARK: table view methods
    
    // method to select the number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == searchTableView {
            if is_searching == true {
                return searchingDataArray.count
            }
            else
            {
                return dataArray.count
            }
        } else if tableView == sortTableView {
            return sortTableArray.count
            
        }
        else {
            if is_searching == true {
                return searchingDataArray.count
            }
            else
            {
                return dataArray.count
            }
        }
    }
    
    // displaying data in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == searchTableView {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")
            
            cell = UITableViewCell(style: UITableViewCellStyle.value1,
                                   reuseIdentifier: "SearchCell")
            
            if is_searching == true {
                cell?.detailTextLabel?.isEnabled = true
                cell?.textLabel?.text =  searchingDataArray[indexPath.row].Name!
                cell?.textLabel?.textColor = UIColor.lightGray
                cell?.detailTextLabel?.textColor = UIColor.black
                cell?.detailTextLabel?.text = searchingDataArray[indexPath.row].Action!
                //cell.detailTextLabel?.text = searchingDataArray[indexPath.row].Upc!
                // cell.lblPostion.text = searchingDataArray[indexPath.row].Position!
                
            } else {
                cell?.detailTextLabel?.isEnabled = true
                cell?.textLabel?.text =  dataArray[indexPath.row].Name!
                cell?.textLabel?.textColor = UIColor.lightGray
                cell?.detailTextLabel?.text = dataArray[indexPath.row].Action!
                // cell.detailTextLabel?.text = dataArray[indexPath.row].Upc!
                
            }
            return cell!
            
        } else if tableView == sortTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath)
            
            
            cell.textLabel?.text = sortTableArray[indexPath.row]
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
            
            if is_searching == true {
                cell.lblName.text =  searchingDataArray[indexPath.row].Name!
                cell.lblAction.text = searchingDataArray[indexPath.row].Action!
                cell.lblUPC.text = searchingDataArray[indexPath.row].Upc!
                cell.lblPostion.text = searchingDataArray[indexPath.row].Position!
                
                // image caching
                if searchingDataArray[indexPath.row].imageUrl != nil{
                    Alamofire.request("\(searchingDataArray[indexPath.row].imageUrl!)").responseImage { response in
                        cell.productImage.image = UIImage(data: response.data!)
                    }
                }
            } else {
                
                cell.lblName.text =  dataArray[indexPath.row].Name!
                cell.lblAction.text = dataArray[indexPath.row].Action!
                cell.lblUPC.text = dataArray[indexPath.row].Upc!
                cell.lblPostion.text = dataArray[indexPath.row].Position!
                
                //image caching
                if dataArray[indexPath.row].imageUrl != nil{
                    Alamofire.request("\(dataArray[indexPath.row].imageUrl!)").responseImage { response in
                        cell.productImage.image = UIImage(data: response.data!)
                    }
                }
            }
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView == searchTableView {
            searchTableView.removeFromSuperview()
            searchingDataArray = [searchingDataArray[indexPath.row]]
            clickedObject = searchingDataArray[indexPath.row]
            print(clickedObject)
            is_productSearch = true
            self.tableView.reloadData()
        } else if tableView == sortTableView {
            sortTableView.removeFromSuperview()
            sortTextFieldText = sortTableArray[indexPath.row]
            self.tableView.reloadData()
        } else {
           if is_searching != true {
             clickedObject = dataArray[indexPath.row]
            }
            if (clickedObject != nil) {
                loadDisplayView(itemObject:clickedObject!)
                }
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if tableView == searchTableView {
            return nil
        } else if tableView == sortTableView {
            return nil
        } else {
            let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTableViewCell
            header.subView.isHidden = true
            if is_productSearch == true {
                header.subView.isHidden = false
                header.sortTextField.delegate = self
                header.btnBackArrow.addTarget(self, action: #selector(ViewController.backArrowAction), for: UIControlEvents.touchUpInside)
                header.productName.text = searchingDataArray[0].Name
            }else {
                header.subView.isHidden = true
                header.sortTextField.delegate = self
                header.sortTextField.text = sortTextFieldText
                header.btnForwardArrow.addTarget(self, action: #selector(ViewController.test), for: UIControlEvents.touchUpInside)
            }
            return header
            
        }
        
    }
    func test() {
        print("test")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height:CGFloat?
        if tableView == searchTableView {
            height = 0
        } else if tableView == sortTableView {
            height = 0
        }else{
            height = 50
        }
        return height!
    }
    
    // setting cell row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height:CGFloat?
        if tableView == searchTableView {
            height = 45
        } else if tableView == sortTableView {
            height = 25
        }else{
            height = 150
        }
        return height!
    }
    
    // MARK: search bar methods
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        is_searching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        is_searching = true
        is_productSearch = true
        searchTableView.removeFromSuperview()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        is_searching = false
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel")
    }
   
    
    // search method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchBar.text!.isEmpty{    // checking if searchbar is empty
            is_searching = false
            self.tableView.reloadData()
        }else if searchText ==  "\n" {
            searchTableView.removeFromSuperview()
            tableView.reloadData()
        }else {
            is_searching = true
            AddSearchTableView()
            if Int(searchText) != nil {  // checking for entered input is upc or name
                searchingDataArray = dataArray.filter(){ (ModelClass) -> Bool in
                    let range = ModelClass.Upc!.range(of: searchText,   options:NSString.CompareOptions.numeric)
                    return range != nil }
                self.searchTableView.reloadData()
            } else {
                searchingDataArray = dataArray.filter(){ (ModelClass) -> Bool in
                    let range = ModelClass.Name!.range(of: searchText,   options:NSString.CompareOptions.caseInsensitive)
                    return range != nil }
                self.searchTableView.reloadData()
            }
        }
    }
    
    
    //MARK: TextField methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        AddSortTableView()
        picker.isHidden = false
        self.picker.isHidden = false
        self.picker.dataSource = self
        self.picker.delegate = self
        self.picker.frame = CGRect( x: 100, y: 0, width: 200, height: 200)
        self.picker.backgroundColor = UIColor.white
        self.picker.layer.borderColor = UIColor.white.cgColor
        self.picker.layer.borderWidth = 1
        
        // textField.inputView = self.picker
        // textField.leftView = self.picker
        
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = selectedBy
        resignFirstResponder()
    }
    
    //MARK: PickerView Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedBy = pickerArray[row]
        picker.isHidden = true
        resignFirstResponder()
    }
    
    //MARK: Parsing data from server
    
    func parsing(){
        
        _ = Alamofire.request("https://api.myjson.com/bins/aiaun/?get")
            
            .responseJSON {  response in
                
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) // JSON serialization
                    
                    if let response = json as? NSDictionary{
                        if let imageTask = response.object(forKey: "imageURL")  {
                            self.mainImageUrl = imageTask as! String
                        }
                        if let task = response.object(forKey: "corretive_actions") as? NSArray {
                            for index in task{
                                if let dictionaryResponse = index as? NSDictionary{
                                    self.dataArray.append(ModelClass(json: dictionaryResponse))
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async(execute: {  // reload table in main thread
                        self.tableView.reloadData()
                        self.image(imageString: self.mainImageUrl, imagev: self.mainImage)
                    })
                }
                catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    
                    // error disply using alert
                    // MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                    let actionController: UIAlertController = UIAlertController(title: "Alert", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    //  Create and add the Cancel action
                    let cancelAction: UIAlertAction = UIAlertAction(title: "ok", style: .cancel) { action -> Void in
                    }
                    actionController.addAction(cancelAction)
                    self.present(actionController, animated: true, completion: nil)
                }
                
        }
        
    }
    
    //image downloading using Alamofire
    func image(imageString: String, imagev: UIImageView) {
        Alamofire.request("\(imageString)?get").responseImage { response in
            imagev.image = UIImage(data: response.data!)
        }
    }
    
    func backArrowAction(sender:UIButton) {
        
        is_productSearch = false
        is_searching = false
        tableView.reloadData()
        
    }
    
    func buttonPressedAction(string: String) -> String {
        let str = string
        print(str)
        return str
    }
    func btnCancelPressed(string: String) {
        displayView.removeFromSuperview()
    }
    func loadDisplayView(itemObject: ModelClass) {
        
        displayView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height)
        //displayView.backgroundColor = UIColor.lightGray
        self.view.addSubview(displayView)
        
        if let customView:PopUp = Bundle.main.loadNibNamed("popup", owner: self, options: nil)?.first as? PopUp {
            customView.center = CGPoint(x: displayView.center.x, y: displayView.center.y)
            customView.delegate = self
            customView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            Alamofire.request("\(itemObject.imageUrl!)").responseImage { response in
                customView.productImageView.image = UIImage(data: response.data!)
            }
            customView.lblIssue.text = itemObject.Action
            customView.lblUpc.text = itemObject.Upc
            customView.lblProductName.text = itemObject.Name
            displayView.addSubview(customView)
            
        }
        
    }
    
}

