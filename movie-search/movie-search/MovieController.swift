//
//  MovieController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation


class MovieController {
    
    var nowPlayingMovies: [Movie] = []
    var searchedMovies: [Movie] = []
    var watchlistMovies: [Movie] = []
    
    static let sharedController = MovieController()
    
    func nowPlayingMovies(completion: (success: Bool) -> Void) {
        
        guard let url = NetworkController.nowPlayingURL else {
            
            // Can't continue without a URL
            print("Unable to get legitimate URL")
            return
        }
        
        NetworkController.dataAtURL(url) { (resultsData) in
            
            // Can't continue if no data was returned
            guard let data = resultsData else {
                print("No Data was returned. Try checking the URL")
                completion(success: false)
                return
            }
            
            do {
                
                let JSONObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let resultsDictionary = JSONObject as? [String: AnyObject], resultsArray = resultsDictionary["results"] as? [[String: AnyObject]] {
                                        
                    self.nowPlayingMovies = resultsArray.flatMap({ Movie(jsonDictionary: $0) })
                    
                    completion(success: true)
                } else {
                    
                    completion(success: false)
                }
                
            } catch {
                completion(success: false)
            }
        }
    }
    
    func searchMoviesWithTitle(title: String, completion: (success: Bool) -> Void) {
        
        guard let url = NetworkController.searchURL(title) else {
            print("Not a valid URL")
            completion(success: false)
            return
        }
        
        NetworkController.dataAtURL(url) { (resultsData) in
            
            guard let data = resultsData else {
                print("results data was nil")
                completion(success: false)
                return
            }
            
            do {
                let JSONObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let resultsDictionary = JSONObject as? [String: AnyObject], resultsArray = resultsDictionary["results"] as? [[String: AnyObject]] {
                    
                    self.searchedMovies = resultsArray.flatMap({ Movie(jsonDictionary: $0) })
                    
                    completion(success: true)
                } else {
                    
                    completion(success: false)
                }
                
            } catch {
                completion(success: false)
            }
        }
    }
}