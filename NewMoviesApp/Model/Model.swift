//
//  Model.swift
//  NewMoviesApp
//
//  Created by muhammed dursun on 1.10.2023.
//

import Foundation

// Decodable : ilgili sınıf, Json verilerini NESNELERE DÖNÜŞTÜRÜR.
// Encodable : İlgili sınıf, nesnelerini JSON FORMATINA dönüştürür.
// Codable   : Hem Decodable hemde Encodable 'dır.

struct DataMovies: Codable {
    
    let movies : [MovieModel]?
    
    private enum CodingKeys: String,CodingKey{
        
        case movies = "results"
    }
    
}

struct MovieModel : Codable {
    
    let title : String?
    let year : String?
    let rate : Double?
    let overview : String?
  
    /*
                        CodingKey ( Kodlama Anahtarı ) :
     
     - Kullandığım API'nın yapısı İSİMLENDİRME PRENSİPLERİME UYMAYAN İSİM'lere sahipse modelin isimleride öyle olmak
       zorunda kalır. Buda kodun kalitesini düşürür.Bunun olmaması için CodingKey 'i kullanırız.
     - Decodable ve Encodable yapmada anahtar olarak olarak kullanılan bir türdür.
     - Modellerimizin özelliklerini değiştirmemizi sağlar.
    
    */
    private enum CodingKeys : String, CodingKey {
        
        case title,overview
        case year = "release_date" // yayın tarihi
        case rate = "vote_average" // Oy ortalaması
    }
    
}




