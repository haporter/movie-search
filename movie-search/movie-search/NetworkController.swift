//
//  NetworkController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let nowPlayingURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=2f8796b287c2f5c208d03dabe8515190")
    
    static func searchURL(_ searchTerm: String) -> URL? {
        
        let modifiedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        
        return URL(string: "https://api.themoviedb.org/3/search/movie?query=\(modifiedSearchTerm)&api_key=2f8796b287c2f5c208d03dabe8515190")
    }
    
    static func dataAtURL(_ url: URL, completion: @escaping (_ resultsData: Data?) -> Void) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url, completionHandler: { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                
            } else {
                completion(data)
            }
        }) 
        
        dataTask.resume()
    }
}
