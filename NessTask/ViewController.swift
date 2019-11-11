//
//  ViewController.swift
//  NessTask
//
//  Created by jagadeesh on 11/11/19.
//  Copyright © 2019 Diksha. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableviewCountries: UITableView!
    var countriesListArray  = [Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountriesListAPICall()
        // Do any additional setup after loading the view.
    }
    
    //MARK: UITableViewDelegates snd Datasourse.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.countriesListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        if let dataDict:[String:Any] = (countriesListArray[indexPath.row] as? [String:Any]){
            
            if let countryName:String = dataDict["name"] as? String{
            
               cell.textLabel?.text = countryName
            }
        }
        else {
            cell.textLabel?.text = "Not ...."
        }
        
        //cell.textLabel?.text =  "Sushma"
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.textColor = UIColor.blue
        
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let dataDict:[String:Any] = (countriesListArray[indexPath.row] as? [String:Any]){
           
            if let callingCodes:[String] = dataDict["callingCodes"] as? [String]{
                
                if let countryIdStr: String = callingCodes[0] as? String{
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
                    nextViewController.countryId = countryIdStr
                    self.present(nextViewController, animated:true, completion:nil)
                }
                
            }
            
        }
        
    }
    
//MARK: API Implementation..
    
    func  getCountriesListAPICall() {
        
        let urlStr = "https://restcountries.eu/rest/v2/all"
        apiMethodCall(urlStr: urlStr, parameters: ["":""]) { (data, error) in
            
            if (error != nil){
                print("error is ::\(String(describing: error?.localizedDescription))");
            }
            else{
                
                if let dataArray:[Any] = data as? [Any] {
                   self.countriesListArray = dataArray
                }
               // print("self.countriesListArray..\(self.countriesListArray.count)")
                DispatchQueue.main.async {
                    self.tableviewCountries.reloadData()
                }
                
            }
        }
    }

}

