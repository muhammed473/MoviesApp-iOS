//
//  myNavigationController.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 21.10.2023.
//

import Foundation
import UIKit

class MyNavigationController : UINavigationController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    viewControllers = [SplashScreen()] // viewControllers Şuanda gezinen görünüm denetleyicileri
        
    }
    
    func goNewHomeScreen() {
        
        let newhomeScreen = NewHomeScreen()
       pushViewController(newhomeScreen, animated: true)
        
        viewControllers.removeAll{
            $0 is SplashScreen
        }
    }
    
    func goDetailScreen(model:MovieModel) {
        
        let detailScreen = DetailScreen()
        detailScreen.detailScreenForModel = model
        
        pushViewController(detailScreen, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
