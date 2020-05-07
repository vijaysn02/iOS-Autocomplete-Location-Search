//
//  Router.swift
//  Auto Complete Location
//
//  Created by TPFLAP146 on 07/05/20.
//  Copyright © 2020 vijay. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Auto Complete
class Router {
    
    static func navigateToAutoCompleteViewController(parentViewController:UIViewController) {
          DispatchQueue.main.async {
              
              let transition = CATransition()
              transition.duration = Constants.StoryBoards.TRANSITION_DURATION
              transition.type = .push
              transition.subtype = .fromRight
              parentViewController.view.window!.layer.add(transition, forKey: kCATransition)
    
              let storyboard = UIStoryboard(name: "AutoComplete", bundle: nil)
              let viewControllerToPresent = storyboard.instantiateViewController(withIdentifier: "AutoCompleteViewController") as! AutoCompleteViewController
              
              viewControllerToPresent.modalPresentationStyle = .fullScreen
            viewControllerToPresent.delegate = (parentViewController as! AutoCompleteDelegate)
              
              parentViewController.present(viewControllerToPresent, animated: false, completion: nil)
              
          }
      }
      static func closeViewController(viewController:UIViewController) {
             DispatchQueue.main.async {
                 
                 //Transition from left to right
                 let transition = CATransition()
                 transition.duration = Constants.StoryBoards.TRANSITION_DURATION
                 transition.type = .push
                 transition.subtype = .fromLeft
                 viewController.view.window!.layer.add(transition, forKey: kCATransition)
                 
                 viewController.dismiss(animated: false, completion: nil)
                 
             }
         }
    
    
}
