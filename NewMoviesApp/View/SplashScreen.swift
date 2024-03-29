//
//  ViewController.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 25.09.2023.
//

import UIKit

class SplashScreen: UIViewController {
    
    var timer = Timer()
    var counter = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 3
        view.backgroundColor = .red
        
      
        if NetworkScreen.shared.isConnected{
            print("Bağlandım len..")
            
            // Firebase remote config 'ten gelen Lodos Texti
            
            
            fetchRemoteConfig()
            GetRemoteValue()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counterStart), userInfo: nil, repeats: true)
        }
        else{
            alertShow()
            
            // Uyarı ve sonraki sayfa(AnaSayfaya Geçilmicek )
        }
        
        view.addSubview(myLodosLabel)
        LabelConstraintAndDefaultValue()
       
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
    
    
    private let myLodosLabel : UILabel = {
        
        let lodosLabel = UILabel()
        lodosLabel.font =  UIFont.systemFont(ofSize: 30,weight: .bold)
        lodosLabel.translatesAutoresizingMaskIntoConstraints = false
         return lodosLabel
    }()
    
    
    private func LabelConstraintAndDefaultValue() {
        myLodosLabel.text = ""
        myLodosLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLodosLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    
    func fetchRemoteConfig(){
        
        remoteConfig.fetch(withExpirationDuration: 1) {
            
            [unowned self]
            (state,error) in
            
            guard error == nil else {return}
            print("Değeri Remote Config 'ten al.")
            remoteConfig.activate()
            self.GetRemoteValue()
            
        }
       
    }
    
    
    func  GetRemoteValue() {
        
        let newLabel = remoteConfig.configValue(forKey: "myCase").stringValue ?? ""
        myLodosLabel.text = newLabel
       
    }
    
    
    @objc func counterStart() {
        
        
        counter -= 1
        
        if counter == 0 {
            timer.invalidate() // Timer  durduruldu.
            print("ŞİMDİ ANA SAYFAYA GEÇEBİLİRSİN.")
            
            
            /*  let homePageScreen = HomePageScreen()
             
             navigationController?.pushViewController(homePageScreen, animated: true)
             } */
            
             let newHomeScreen = NewHomeScreen()
            navigationController?.pushViewController(newHomeScreen, animated: true)
         
            
          
            
         //   MyNavigationController().goNewHomeScreen()
        }
        
    }
    
    
    
}
