//
//  NewViewController.swift
//  ZoomingAnimation
//
//  Created by Manoj TR on 3/9/17.
//  Copyright © 2017 Manoj TR. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newimage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    @IBAction func download(_ sender: Any) {
        imageDownload()
    }
    
    var one: [String] = []
    var two: [String] = []
    var three: [String] = []
    var four: [String] = []
    var five: [String] = []
    var imageArray: [UIImage] = []
    var samArray = ["1", "2", "3", "4", "5"]
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.shadowColor = UIColor.blue.cgColor
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowOffset = CGSize.zero
        tableView.layer.shadowRadius = 10
        
//        tableView.layer.shadowPath = UIBezierPath(rect: tableView.bounds).cgPath
//        tableView.layer.shouldRasterize = true
//        tableView.layer.rasterizationScale = UIScreen.main.scale
        tableView.clipsToBounds = false
        tableView.layer.masksToBounds = false
        
        imageDownload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return one.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = one[indexPath.row]
       
        if three[indexPath.row] != nil {
            
            Alamofire.request("\(three[indexPath.row])").responseImage { response in

        cell.imageView?.image = UIImage(data: response.data!)
                
            }
            
        }
        
        
        return cell
    }
    
    
    
    func imageDownload() {
        
        var newimagedata: String = ""
        
        Alamofire.request("https://api.myjson.com/bins/aiaun/?get").responseJSON { response in
            
            switch response.result {
            case .success:
                if let result = response.result.value {
                    
                    let JSON = result as! NSDictionary
                    
                    if let a = JSON.object(forKey: "imageURL") {
                        newimagedata = a as! String
                    }
                    
                    if newimagedata != "" {
                        
                        DispatchQueue.main.async(execute: {
                        self.image(imageString: newimagedata, imagev: self.newimage)
                        })
                       
                    }
                    if let b = JSON.object(forKey: "corretive_actions") {
                        
                        let tasks = b as! NSArray
                        
                    
                        for task in tasks {
                            
                            let c = task as! NSDictionary
                            
                            if let Name = c.object(forKey: "name") {
                                self.one.append(Name as! String)
                            }
                            if let Upc = c.object(forKey: "upc") {
                                self.two.append(Upc as! String)
                            }
                            if let Image = c.object(forKey: "image") {
                                self.three.append(Image as! String)
                               
//                                Alamofire.request("\(Image)?get").responseImage { response in
//                                    
////                                    var im: UIImage?
////                                     im = UIImage(data: response.data!)!
////                                    if im != nil {
////                                        self.imageArray.append(im!)
////                                        }
//                                    self.image1.image = UIImage(data: response.data!)
//                                    
//                                    }
                                
                                //self.image(imageString: Image as! String, imagev: self.image1)
                                
                            }
                            if let Position = c.object(forKey: "position") {
                                self.four.append(Position as! String)
                            }
                            if let Action = c.object(forKey: "action") {
                                self.five.append(Action as! String)
                            }
                        }
                        print(self.one)
                        print(self.two)
                        print(self.three)
                        print(self.four)
                        print(self.five)
                        print(self.imageArray.count)
                    }
                    print(result)
                }
                
               
                DispatchQueue.main.async ( execute: {
                    self.tableView.reloadData()
                })
                
                
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func image(imageString: String, imagev: UIImageView) {
       
        Alamofire.request("\(imageString)?get").responseImage { response in
            
            imagev.image = UIImage(data: response.data!)
        }
    }

    

}
