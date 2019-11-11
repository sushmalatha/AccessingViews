//
//  Alert+Extension.swift
//  NessTask
//
//  Created by jagadeesh on 11/11/19.
//  Copyright © 2019 Diksha. All rights reserved.
//

import Foundation
import UIKit
import WebKit

extension UIView{
    
    func activityStartAnimating(activityColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        UIApplication.shared.keyWindow!.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        backgroundView.addSubview(activityIndicator)
        self.addSubview(backgroundView)
        
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
