//
//  MovieViewModel.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 10.10.2023.
//

import Foundation

class MovieViewModel{
    
    private var apiService = ApiService()
    private var popularMovies = [MovieModel]()
    
    
    func fetchPopularMoviesData(completion: @escaping () -> Void ) {
        
        apiService.getPopularMoviesData {
            
         [weak self]  (result) in
            
            switch result {
                
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
                
            case .failure(let error):
                print("Json verileri işlenirken hata oluştu.\(error)")
               
            }
        }
        
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
        
    }
    
    func cellForRowAt (indexPath : IndexPath) -> MovieModel {
        
        return popularMovies[indexPath.row]
    }
    
    
}
