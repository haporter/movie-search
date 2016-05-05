//
//  NetworkController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let nowPlayingURL = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=2f8796b287c2f5c208d03dabe8515190")
    
    static func searchURL(searchTerm: String) -> NSURL? {
        
        let modifiedSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        return NSURL(string: "https://api.themoviedb.org/3/search/movie?query=\(modifiedSearchTerm)&api_key=2f8796b287c2f5c208d03dabe8515190")
    }
    
    static func dataAtURL(url: NSURL, completion: (resultsData: NSData?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(resultsData: nil)
                
            } else {
                completion(resultsData: data)
            }
        }
        
        dataTask.resume()
    }
}