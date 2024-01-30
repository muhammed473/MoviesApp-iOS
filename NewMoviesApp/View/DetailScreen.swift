//
//  DetailScreen.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 18.10.2023.
//

import UIKit
import SDWebImage

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
    var movieDataList : [MovieModel] = []
    var newApiService  = NewApiService()
    
   
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
        
   
       getImage()
        
        guard let movieDetail = detailScreenForModel else {return}
        guard let url = movieDetail.poster else {return}
       
        myImageView.sd_setImage(with: URL(string:url))
       
    }
    
   /*  func fff(){
        
        let urlString4 = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        guard let url = URL(string: urlString4) else {return}
        
        self.dataTask = URLSession.shared.dataTask(with: url)
        {
            (data,response,error) in
            
           /* guard let data = data, error == nil else {return} */
            
            // Handle Error : HATA var mı kontrol ettik.
            if let error = error {
                
                print("Veri Görevi ( DataTask ) hatası : \(error.localizedDescription)")
                return
            }
            
            guard let data = data  else{
                print("Veri Boş.")
                return
            }
            
            do{
                
                DispatchQueue.main.async {
               
                    self.myImageView.sd_setImage(with:URL(string:urlString4)?.scheme)
                    
                }
                
            } catch{
              print(error)
            }
         
        }
        dataTask?.resume()
        
        NOT :
         
         https://medium.com/swlh/loading-images-from-url-in-swift-2bf8b9db266
         BU ADRESTEN Api'deki bir resmi nasıl kendi ekranımızda görüntüleyeceğimizi ANLADIN. Böyle
         bir şeyle karşılaştığında bu adrese gidip hatırlayabilirsin.
         
         */
    
    
    
  
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
 
    
    func getImage() {
        
        let popularMoviesImageUrl = "https://api.themoviedb.org/3/images/A4j8S6moJS2zNtRR8oWF08gRnL5.jpg"
        
        let url = URL(string: popularMoviesImageUrl)!
        
        let dataTask = URLSession.shared.dataTask(with: url) {
            (data,response,error) in
            
            if let data = data,let image = UIImage(data: data) {
                
               print("Belirlediğin filmin resim bilgisi doğru.")
// /A4j8S6moJS2zNtRR8oWF08gRnL5.jpg
            }
            
        }
        
    }
    

}
