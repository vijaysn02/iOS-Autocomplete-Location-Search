//
//  ViewController.swift
//  API Master
//
//  Created by TPFLAP146 on 03/05/20.
//  Copyright © 2020 vijay. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - View Controller - Initialization
class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

//MARK: - Button Actions
extension ViewController {
    
    @IBAction func locationButtonClicked(_ sender: Any) {
        Router.navigateToAutoCompleteViewController(parentViewController: self,searchType: .pointOfInterest)
    }
    
}

//MARK: - Auto Complete Delegate
extension ViewController:AutoCompleteDelegate {
  
    func selectedLocation(location: CLLocationCoordinate2D, locationName: String) {
        Toast.showasync(message: locationName, controller: self)
    }
    
}

