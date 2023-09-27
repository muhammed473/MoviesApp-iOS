//
//  HomePageController.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 27.09.2023.
//

import UIKit

class HomePageController: UIViewController {

 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        print("Şuanda 2 'inci ekrandayım.")
        
        view.addSubview( ForLoadingActivityIndicator)
        actiIndicatorConstraint()
    }
    

  //  UIActivityIndicatorView, hidden,start,stop
    
   private let ForLoadingActivityIndicator : UIActivityIndicatorView  = {
        
       let myActiIndicator = UIActivityIndicatorView()
      
       myActiIndicator.translatesAutoresizingMaskIntoConstraints = false
       myActiIndicator.color = .yellow
       myActiIndicator.isHidden = false
       myActiIndicator.startAnimating()
      
        return myActiIndicator
    }()
    
    private func actiIndicatorConstraint() {
        
        ForLoadingActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ForLoadingActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

}
