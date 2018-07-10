//
//  BaseViewController.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController, NVActivityIndicatorViewable{
    
    enum AppStoryboard : String {
        case Main, Payment
        var instance : UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        }
    }
  
    let activityData = ActivityData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

