//
//  NewHomeScreen.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 10.10.2023.
//

import UIKit

class NewHomeScreen: UIViewController {
    
    // var apiService = ApiService()
    
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  view.backgroundColor = .blue
         print("Şuanda 2 'inci YENİ ekrandayım.")
         
         
         apiService.getPopularMoviesData {
         
         (result) in
         
         print(result)
         
         } */
        
        loadingMoviesData()
        
        view.backgroundColor = .blue
        print("Şuanda 2 'inci YENİ ekrandayım.")
        
        view.addSubview(ForLoadingActivityIndicator)
        view.addSubview(mytableView)
        actiIndicatorConstraint()
        tableViewConstraint()
        
    }
    
    private let mytableView : UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        tableView.allowsSelection = true // Satır seçimine izin verildi.
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.tableIdentifier)
        
        return tableView
    }()
    
    private func tableViewConstraint() {
        
        mytableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 2).isActive = true
        mytableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mytableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2).isActive = true
        mytableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        
        
    }
    
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
    
    
    private func loadingMoviesData(  ) {
        
        viewModel.fetchPopularMoviesData { [weak self] in
            
            self?.mytableView.dataSource = self
            self?.mytableView.delegate = self
            self?.mytableView.reloadData()
        }
    }
    
}

extension NewHomeScreen: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.tableIdentifier, for: indexPath) as! MyTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        
        
        cell.setCellWithValuesOf(movie)
        
        return cell
        
    }
    
    
}
