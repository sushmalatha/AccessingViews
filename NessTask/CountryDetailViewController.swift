//
//  CountryDetailViewController.swift
//  NessTask
//
//  Created by jagadeesh on 11/11/19.
//  Copyright © 2019 Diksha. All rights reserved.
//

import UIKit
import WebKit

class CountryDetailViewController: UIViewController {
    
    var countryId:String = " "
    
    @IBOutlet weak var imageView: WKWebView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLael: UILabel!
    @IBOutlet weak var subRegionLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("countryIdStr..\(countryId)")
        getCountriesDetailAPICall()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
//MARK: API Implementation..

extension CountryDetailViewController{
    
    func  getCountriesDetailAPICall() {
        
        self.view.activityStartAnimating(activityColor: UIColor.gray)
        let urlStr = "https://restcountries.eu/rest/v2/callingcode/" + countryId
        
        apiMethodCall(urlStr: urlStr, parameters: ["":""]) { (data, error) in
            
            if (error != nil){
                
                self.view.activityStopAnimating()
                print("error is ::\(String(describing: error?.localizedDescription))");
                
            }
            else{
                DispatchQueue.main.async {
                    
                    self.view.activityStopAnimating()
                    
                }
                if let dataArray:[Any] = data as? [Any] {
                    //print("data array..\(dataArray)")
                    
                    DispatchQueue.main.async {
                        
                        if let dataDictionary:[String:Any] = dataArray[0] as? [String:Any]{
                            // image
                            if let imageUrl:String = dataDictionary["flag"] as? String{
                                print("image....\(imageUrl)")
                                let url = URL(string: imageUrl)
                                if (url != nil){
                                  let requestObj = URLRequest(url: url! as URL)
                                    self.imageView.load(requestObj)
                                }
                            }
                            else{
                            }
                            //Country Name
                            if let countryName:String = dataDictionary["name"] as? String{
                                self.countryNameLabel.text = countryName
                            }
                            else{
                                self.countryNameLabel.text = " "
                            }
                            //Capital
                            if let capitalName:String = dataDictionary["capital"] as? String{
                                self.capitalLael.text = "Capital  : " + capitalName
                            }
                            else{
                                self.capitalLael.text = " "
                            }
                            
                            //Region
                            if let regionName:String = dataDictionary["region"] as? String{
                                self.regionLabel.text = "Region  : " + regionName
                            }
                            else{
                                self.regionLabel.text = " "
                            }
                            //subregion
                            if let subRegionName:String = dataDictionary["subregion"] as? String{
                                self.subRegionLabel.text = "SubRegion  : " + subRegionName
                            }
                            else{
                                self.subRegionLabel.text = " "
                            }
                            
                            // Currency
                            if let currencyArray:[Any] = dataDictionary["currencies"] as? [Any]{
                                
                                if let currencDict:[String:Any] = (currencyArray[0] as? [String:Any]){
                                    
                                    if let currencName:String = currencDict["code"] as? String{
                                        
                                        self.currencyLabel.text = "Currency  : " + currencName
                                    }
                                }
                                else{
                                    self.currencyLabel.text = " "
                                }
                            }
                            else{
                                self.regionLabel.text = " "
                            }
                        }
                        
                    }
                }
            }
        }
    }
 
}


