//
//  DetailScreen.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 18.10.2023.
//

import UIKit

class DetailScreen: UIViewController {

    private let myImageView: UIImageView = {
        let viewImage = UIImageView()
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        //viewImage.image = UIImage()
      
        return viewImage
    }()
    private let myLabel : UILabel = {
        
        let myLabelim = UILabel()
        myLabelim.font =  UIFont.systemFont(ofSize: 30,weight: .bold)
        myLabelim.translatesAutoresizingMaskIntoConstraints = false
         return myLabelim
    }()
    private let myLabelYear : UILabel = {
        
        let myLabelim = UILabel()
        myLabelim.font =  UIFont.systemFont(ofSize: 30,weight: .bold)
        myLabelim.translatesAutoresizingMaskIntoConstraints = false
         return myLabelim
    }()
    
    var newHomeScreen = NewHomeScreen()
    var detailScreenForModel : MovieModel?
    private var dataTask : URLSessionDataTask?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Şuanda Film Detay ekranındayım.")
        view.backgroundColor = .systemBlue
        
    
        navigationItem.title = "DetailScreen"
        
        view.addSubview(myImageView)
        setUpImageViewConstraint()
        
        view.addSubview(myLabel)
        LabelConstraintAndDefaultValue()
        
        view.addSubview(myLabelYear)
        LabelYearConstraintAndDefaultValue()
    
        myLabel.text = self.detailScreenForModel?.title
        myLabelYear.text = "MOVİE YEAR : \(self.detailScreenForModel!.year!)"
        /* NOT :
         
         https://medium.com/swlh/loading-images-from-url-in-swift-2bf8b9db266
         BU ADRESTEN Api'deki bir resmi nasıl kendi ekranımızda görüntüleyeceğimizi ANLADIN. Böyle
         bir şeyle karşılaştığında bu adrese gidip hatırlayabilirsin.
         
         */
        
        // poster_path":"/mOX5O6JjCUWtlYp5D8wajuQRVgy.jpg
        
     
    }
    
    func getImageFromApi(from url:String) { // BU HALDE KALSIN SONRA İLERDE ÇALIŞAN KODLARI BU METOD ÜZERİNDE DEĞİŞTİRİRSİN ! ! !
        
        guard let comeImageUrl = URL(string: url) else {return}
        
        DispatchQueue.global().async {
            
            guard let myImageData = try? Data(contentsOf: comeImageUrl) else {return}
            let myImage = UIImage(data: myImageData)
            
            DispatchQueue.main.async {
                
            
                self.myImageView.image = myImage
            }
        }
        
        
    } 
    
    private func setUpImageViewConstraint(){
 
        myImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        myImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myImageView.centerYAnchor.constraint(equalTo: view.topAnchor,constant: 250).isActive = true
    }
    
    
    private func LabelConstraintAndDefaultValue() {
    //    myLabel.text = "Selam"
        myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func LabelYearConstraintAndDefaultValue() {
    //    myLabel.text = "Selam"
        myLabelYear.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 30).isActive = true
        myLabelYear.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 30).isActive = true
        
    }
 
    

}
