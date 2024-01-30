//
//  ApiService.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 10.10.2023.
//

import Foundation

class ApiService {
    
    private var dataTask : URLSessionDataTask?
    
    func getPopularMoviesData(imdbID:String, completion: @escaping( DataMovies) -> Void ){
        
        let popularMoviesUrl = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        
        guard let url = URL(string: popularMoviesUrl) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url)
        {
            
            (data,response,error) in
            
            // Handle Error : HATA var mı kontrol ettik.
            if let error = error {
               // completion(.failure(error))
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
                let movieDataList = try decoder.decode(DataMovies.self, from: data)
                
               
            } catch let error{
                print("Error : \(error.localizedDescription)")
                
            }
            
        }
        
        dataTask?.resume()
        
        
    }
    
    
    
    
}
