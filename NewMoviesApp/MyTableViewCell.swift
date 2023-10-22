//
//  MyTableViewCell.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 1.10.2023.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let tableIdentifier = "myCell"
   
    private var urlString : String = ""
    
    let movieTitleLabel : UILabel = {
    
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 30,weight: .bold)
    label.text = " How Are You "
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError( "Kodlayıcı başlayamadı." )
    }
    
    private func setUpConstraint(){
        
        self.contentView.addSubview(movieTitleLabel)
       
        movieTitleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: 2 ).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 2).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 2).isActive = true
        movieTitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: 2).isActive = true
            
    }
    
    func setCellWithValuesOf(_ movie:MovieModel){
        
    cellUpdate(title: movie.title!)
        
    }
    
    private func cellUpdate(title : String ) {
        
        self.movieTitleLabel.text = title
    
    }
   
   
  
    
    

}
