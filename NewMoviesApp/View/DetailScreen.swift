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
        viewImage.image = UIImage(named: "Avatar")
      
        return viewImage
    }()
    private let myLabel : UILabel = {
        
        let myLabelim = UILabel()
        myLabelim.font =  UIFont.systemFont(ofSize: 30,weight: .bold)
        myLabelim.translatesAutoresizingMaskIntoConstraints = false
         return myLabelim
    }()
    
    var newHomeScreen = NewHomeScreen()
    var detailScreenForModel : MovieModel?
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Şuanda Film Detay ekranındayım.")
        view.backgroundColor = .systemBlue
        
       /* newhome.getDetail {
            (detailmodel) in
            
            print("ÇALIŞTI.")
            self.myLabel.text = self.newhome.currentMovieDetailList[0].title
            
        } */
      
        navigationItem.title = "DetailScreen"
        view.addSubview(myImageView)
        setUpImageViewConstraint()
        
        view.addSubview(myLabel)
        LabelConstraintAndDefaultValue()
        
      //  guard let detailmodels = detailmodels else {return}
        myLabel.text = self.detailScreenForModel?.title
       
    
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
    
    
   /* func getImage() {
        
        if let movie = movie {
            if let urlImage = URL(string: "https://api.themoviedb.org/3/movie/results/poster_path/\(movie.real_image)") {
                
                DispatchQueue.global().async {
                    
                    let data = try? Data(contentsOf: urlImage)
                    
                    DispatchQueue.main.async {
                      
                        self.myImageView.image = UIImage(data: data!)
                    }
                }
            }
        }
       
    } */
    

}
