//
//  MovieController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit


class MovieController {
    
    var nowPlayingMovies: [Movie] = []
    var searchedMovies: [Movie] = []
    var watchlistMovies: [Movie] = []
    
    static let sharedController = MovieController()
    
    static func nowPlayingMovies(completion: (success: Bool) -> Void) {
        
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
                                        
                    MovieController.sharedController.nowPlayingMovies = resultsArray.flatMap({ Movie(jsonDictionary: $0) })
                    
                    completion(success: true)
                } else {
                    
                    completion(success: false)
                }
                
            } catch {
                completion(success: false)
            }
        }
    }
    
    static func searchMoviesWithTitle(title: String, completion: (success: Bool) -> Void) {
        
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
                    
                    MovieController.sharedController.searchedMovies = resultsArray.flatMap({ Movie(jsonDictionary: $0) })
                    
                    if MovieController.sharedController.searchedMovies.count == 0 {
                        let nilMovie = Movie(title: "No Movies match this title", overview: "", posterPath: nil, backDropPath: nil, rating: 0.0)
                        MovieController.sharedController.searchedMovies.append(nilMovie)
                    }
                    
                    completion(success: true)
                } else {
                    
                    completion(success: false)
                }
                
            } catch {
                completion(success: false)
            }
        }
    }
    
    static func addMovieToWatchList(movie: Movie) {
        
        MovieController.sharedController.watchlistMovies.append(movie)
    }
    
    static func removeMovieFromWatchlist(movie: Movie) {
        
        if MovieController.sharedController.watchlistMovies.contains(movie) {
            
            if let index = MovieController.sharedController.watchlistMovies.indexOf(movie) {
                
                MovieController.sharedController.watchlistMovies.removeAtIndex(index)
            }
        }
    }
    
    static func imageAtEndpoint(endpoint: String) -> UIImage? {
        
        guard let url = NSURL(string: "http://image.tmdb.org/t/p/w500\(endpoint)"),
                data = NSData(contentsOfURL: url),
                image = UIImage(data: data) else { return nil }
        
         return image
    }
}

















































