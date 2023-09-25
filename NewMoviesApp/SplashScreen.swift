//
//  ViewController.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 25.09.2023.
//

import UIKit

class SplashScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .red
        
        if NetworkScreen.shared.isConnected{
            print("Bağlandım len..")
            
            // Firebase remote config 'ten gelen Lodos Texti
        }
        else{
            alertShow()
            
            // Uyarı ve sonraki sayfa(AnaSayfaya Geçilmicek )
        }
        
    }
    
    
    private func alertShow() {
        
        print("Bağlanamadım.")
        
        let alert = UIAlertController(title: "Error", message: "Not internet connection ", preferredStyle: UIAlertController.Style.alert)
        
        let  doneButton = UIAlertAction(title: "Done", style: UIAlertAction.Style.default)
        {
            (AfterDoneButton) in
            
            // İLK SAYFADA KALIP ANA SAYFAYA GEÇİLMEMESİ SAĞLANACAK
            print("Done butonuna tıklandı şimdi ne yapayım ?")
        }
        
        alert.addAction(doneButton)
        self.present(alert, animated: true,completion: nil)
        
        
        
    }
    
    
}
