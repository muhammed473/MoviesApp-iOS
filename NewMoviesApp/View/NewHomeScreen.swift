//
//  NewHomeScreen.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 10.10.2023.
//

import UIKit

class NewHomeScreen: UIViewController {
    
    
    var isSearch = false
    var searchResultList = [MovieModel]()
    var movieDataList : [MovieModel] = []
   
   
   
    private var dataTask : URLSessionDataTask?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  view.backgroundColor = .blue
         print("Şuanda 2 'inci YENİ ekrandayım.")
         
         
         apiService.getPopularMoviesData {
         
         (result) in
         
         print(result)
         
         } */
        
        getMovies()
        // fetchDetail()
       
        
        mySearchBar.delegate = self
        mytableView.delegate = self
        mytableView.dataSource = self
        
        view.backgroundColor = .blue
        print("Şuanda 2 'inci YENİ ekrandayım.")
        
        view.addSubview(ForLoadingActivityIndicator)
        view.addSubview(mytableView)
        view.addSubview(mySearchBar)
        
        
        actiIndicatorConstraint()
        tableViewConstraint()
        searchBarConstraint()
        
        mytableView.reloadData()
        
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
    
    
    private func getMovies( ) {
        
        /*   apiService.getPopularMoviesData {
         
         [weak self]  (result) in
         
         switch result {
         
         case .success(let listem):
         self?.searchResultList = listem.movies!
         
         
         case .failure(let error):
         print("Hata oluştu.\(error)")
         
         
         }
         
         */
        
        let popularMoviesUrl = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        
        guard let url = URL(string: popularMoviesUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url)
        {
            
            (data,response,error) in
            
            // Handle Error : HATA var mı kontrol ettik.
            if let error = error {
                
                print("Veri Görevi ( DataTask ) hatası : \(error.localizedDescription)")
                return
            }
            
            
            // Handle Empty Response : Boş YANIT var mı kontrol ettik.
            guard let response = response as? HTTPURLResponse else {
                print ("Yanıt(CEVAP) BOŞ")
                return
            }
            print("Yanıt durum kodu : \(response.statusCode)")
            
            
            // Handle Empty Data = Boş DATA var mı kontrol ettik.
            guard let data = data  else{
                print("Veri Boş.")
                return
            }
            
            // Parse the data = Verileri DÜZENLİCEZ(Parse) ŞİMDİ :
            do{
                
                let decoder = JSONDecoder()
                let DataList = try decoder.decode(DataMovies.self, from: data)
                self.movieDataList = DataList.movies!
                
                /*  print("İlgili resmin urlsi : \(movieDataList.contains(where: <#T##(MovieModel) throws -> Bool#>))") */
                
                /*   DispatchQueue.main.async {
                 self.movieDataList
                 
                 } */
                
            } catch let error{
                print(error)
                
            }
            
        }
        
        dataTask?.resume()
        
    }
    
}


extension NewHomeScreen: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
      
        searchResultList = movieDataList.filter({ (s : MovieModel)
            -> Bool in
        
            return s.title!.lowercased().contains(searchText.lowercased())
        })
      
        isSearch = true
        mytableView.reloadData()
        
    
    }
    
    func searchBarIsEmpty() -> Bool {
        
        return mySearchBar.text?.isEmpty ?? true
    }
    
}


extension NewHomeScreen: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        //    return searchResultList.count
        
        if !searchBarIsEmpty() {
            return searchResultList.count
        }
        else{
            return movieDataList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
         let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.tableIdentifier, for: indexPath) as! MyTableViewCell
        
        if !searchBarIsEmpty() {
            cell.movieTitleLabel.text = searchResultList[indexPath.row].title
        }
        else {
            cell.movieTitleLabel.text = movieDataList[indexPath.row].title
        }
     
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Tıkladım")
       
     // fetchDetail()
        
        let detailScreen = DetailScreen()
        
        if !searchBarIsEmpty(){
            detailScreen.detailScreenForModel = searchResultList[indexPath.row]
        }
        
        else {
            detailScreen.detailScreenForModel = movieDataList[indexPath.row]
        }
        
        self.navigationController?.pushViewController(detailScreen, animated: true)
        
       
   
        
    }
    
    
}





