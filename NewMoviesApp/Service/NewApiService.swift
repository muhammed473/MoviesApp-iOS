//
//  NewApiService.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 27.10.2023.
//

import Foundation

class NewApiService {
    
    let apiKey = "9893101c"
    let baseUrl = "http://www.omdbapi.com"
    private var dataTask : URLSessionDataTask?
    let urlSession = URLSession.shared
    
    var liste = [MovieModel]()
    
    /* func getData(keyWords:String,page:Int,completion: @escaping ([MovieModel]) -> Void ) {
     
     //  let url = URL(string: baseUrl+"/?i=\(imdbId)&plot=full&apikey=\(apiKey)")
     let url = URL(string: baseUrl + "/?s=\(keyWords)&page=\(page)&apikey=\(apiKey)")!
     
     
     
     var request = URLRequest(url: url)
     request.httpMethod = "GET"
     
     dataTask = URLSession.shared.dataTask(with: request){
     
     (data,response,error) in
     
     if  error != nil || data == nil {
     print ( "Daha BAŞLANGIÇTA  HATA VAR.")
     }
     
     do{ // Parse the data = Verileri DÜZENLİCEZ (Parse) ŞİMDİ :
     
     let dataList = try JSONDecoder().decode(DataMovies.self, from: data!)
     
     DispatchQueue.main.async {
     completion(dataList.movies!)
     }
     
     return
     
     } catch {
     
     print("Catch kısmında hata var.")
     
     }
     
     } */
    
    func getData2(){
        
        let url2 = URL(string: baseUrl + "?s=power&page=1&apikey=9893101c")
        let url3 = "http://www.omdbapi.com/?s=power&page=1&apikey=9893101c"
        let url4 =   "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        guard let url = URL(string: url4) else {return}
        
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
                self.liste = DataList.movies
                
                print("SAAYIMIZZZ : \(self.liste.count)")
                
            } catch let error{
                print(error)
                
            }
            
        };dataTask?.resume()
        
            
    }
    
        
        
    }
    

