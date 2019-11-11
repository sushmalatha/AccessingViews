//
//  NetworkCalls.swift
//  NessTask
//
//  Created by jagadeesh on 11/11/19.
//  Copyright © 2019 Diksha. All rights reserved.
//

import Foundation

func apiMethodCall(urlStr:String,parameters:Dictionary<String, Any>,completion: @escaping (Any?,Error?) -> ()) {
    
    let replacedPrefix = urlStr.replacingOccurrences(of: " ", with: "")

    let url = URL(string: replacedPrefix)!
    var request : URLRequest = URLRequest(url: url)
    request.httpMethod = "GET"
    let task  = URLSession.shared.dataTask(with: request) { (data, response, erro) in
        
        if erro != nil{
            completion(nil, erro!)
        }
        else{
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                completion(json,nil)
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        
    }
    task.resume()
    
}




