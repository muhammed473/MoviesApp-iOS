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
    
    var isSearch = false
    var searchResultList = [MovieModel]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  view.backgroundColor = .blue
         print("Şuanda 2 'inci YENİ ekrandayım.")
         
         
         apiService.getPopularMoviesData {
         
         (result) in
         
         print(result)
         
         } */
        
        mySearchBar.delegate = self
       
        view.backgroundColor = .blue
        print("Şuanda 2 'inci YENİ ekrandayım.")
        
        view.addSubview(ForLoadingActivityIndicator)
        view.addSubview(mytableView)
        view.addSubview(mySearchBar)
        
        
        actiIndicatorConstraint()
        tableViewConstraint()
        searchBarConstraint()
        
        loadingMoviesData()
        
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
        
        mytableView.topAnchor.constraint(equalTo: mySearchBar.bottomAnchor,constant:5).isActive = true
        mytableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        mytableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2).isActive = true
        mytableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
       

    }
    
    
    private let mySearchBar : UISearchBar = {
        
        let searchText = UISearchBar()
        searchText.translatesAutoresizingMaskIntoConstraints = false
        searchText.backgroundColor = .brown
        return searchText
    }()
    
    private func searchBarConstraint() {
        
        mySearchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        mySearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mySearchBar .trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
     //   mySearchText.bottomAnchor.constraint(equalTo: mytableView.topAnchor, constant: 2).isActive = true
        
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
    
    
   /* func AramaYap ( currentSearchText:String){
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1")!)
     
        
        request.httpMethod = "POST"
        
        let postString = "Movie = \(currentSearchText)"
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request)
        {
            (data,response,error) in
            
            if error != nil || data == nil{
                print("Hata var")
                return
            }
            
            do{
                
                let movieList = try JSONDecoder().decode(DataMovies.self,from: data!)
                
                self.searchResultList = movieList.movies
                    
                
                
                DispatchQueue.main.async {
                    self.mytableView.reloadData()
                }
                
                
            }catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
    } */
    
}

extension NewHomeScreen: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch{
            return searchResultList.count
        }
        
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.tableIdentifier, for: indexPath) as! MyTableViewCell
        
       if isSearch{
            
           
            var content = cell.defaultContentConfiguration()
            content.text = viewModel.cellForRowAt(indexPath: indexPath).title
            cell.contentConfiguration = content
       
       
        }
        else {
           
            let movie = viewModel.cellForRowAt(indexPath: indexPath)
               
            cell.setCellWithValuesOf(movie)

        }
      
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearch {
            print(" Search Result Choose Movie : \(searchResultList[indexPath.row])")
            
        }
        
        else{
            print("Choose Movie(Seçilen Film) : \(viewModel.popularMovies[indexPath.row]) ")
            
        }
    }
    
    
   
    
}

extension NewHomeScreen : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("Şuan arama yapılıyor.")
       
        
        if searchText == ""
        {
            isSearch = false
        }
        else {
            isSearch = true
            searchResultList = viewModel.popularMovies.filter( {$0.title?.lowercased().prefix(searchText.count) ?? "empty" == searchText.lowercased() })
           
        }
        
        mytableView.reloadData()
        
    }
}
