//
//  ViewController.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 25.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        if NetworkScreen.shared.isConnected{
            print("Bağlandım len")
        }
        else{
            print("Bağlanamadım.") // Uyarı mesajlarını yazıcam.
        }
        
    }


}

