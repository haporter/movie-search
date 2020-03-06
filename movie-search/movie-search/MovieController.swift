//
//  MovieController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit


class MovieController {
    
    fileprivate static let kWatchlistMovies = "watchlist"
    
    var nowPlayingMovies: [Movie] = []
    var searchedMovies: [Movie] = []
    var watchlistMovies: [Movie] = []
    
    static let sharedController = MovieController()
    
    static func nowPlayingMovies(_ completion: @escaping (_ success: Bool) -> Void) {
        
        guard let url = NetworkController.nowPlayingURL else {
            
            // Can't continue without a URL
            print("Unable to get legitimate URL")
            return
        }
        
        NetworkController.dataAtURL(url) { (resultsData) in
            
            // Can't continue if no data was returned
            guard let data = resultsData else {
                print("No Data was returned. Try checking the URL")
                completion(false)
                return
            }
            
            do {
                
                let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let resultsDictionary = JSONObject as? [String: AnyObject], let resultsArray = resultsDictionary["results"] as? [[String: AnyObject]] {
                                        
                    MovieController.sharedController.nowPlayingMovies = resultsArray.flatMap({ Movie(jsonDictionary: $0) })
                    
                    completion(true)
                } else {
                    
                    completion(false)
                }
                
            } catch {
                completion(false)
            }
        }
    }
    
    static func searchMoviesWithTitle(_ title: String, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let url = NetworkController.searchURL(title) else {
            print("Not a valid URL")
            completion(false)
            return
        }
        
        NetworkController.dataAtURL(url) { (resultsData) in
            
            guard let data = resultsData else {
                print("results data was nil")
                completion(false)
                return
            }
            
            do {
                let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let resultsDictionary = JSONObject as? [String: AnyObject], let resultsArray = resultsDictionary["results"] as? [[String: AnyObject]] {
                    
                    MovieController.sharedController.searchedMovies = resultsArray.flatMap({ Movie(jsonDictionary: $0) })
                    
                    if MovieController.sharedController.searchedMovies.count == 0 {
                        let nilMovie = Movie(title: "No Movies match this title", overview: "", posterPath: nil, backDropPath: nil, rating: 0.0)
                        MovieController.sharedController.searchedMovies.append(nilMovie)
                    }
                    
                    completion(true)
                } else {
                    
                    completion(false)
                }
                
            } catch {
                completion(false)
            }
        }
    }
    
    static func isOnwatchlist(_ movie: Movie) -> Bool {
        
        if MovieController.sharedController.watchlistMovies.contains(movie) {
            return true
        } else {
            return false
        }
    }
    
    static func addMovieToWatchList(_ movie: Movie) {
        
        MovieController.sharedController.watchlistMovies.append(movie)
        
        saveToUserDefaults()
    }
    
    static func removeMovieFromWatchlist(_ movie: Movie) {
        
        if MovieController.sharedController.watchlistMovies.contains(movie) {
            
            if let index = MovieController.sharedController.watchlistMovies.index(of: movie) {
                
                MovieController.sharedController.watchlistMovies.remove(at: index)
                
                saveToUserDefaults()
            }
        }
    }
    
    static func imageAtEndpoint(_ endpoint: String) -> UIImage? {
        
        guard let url = URL(string: "http://image.tmdb.org/t/p/w500\(endpoint)"),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return nil }
        
         return image
    }
    
    static func saveToUserDefaults() {
        
        let movieDictionaries = MovieController.sharedController.watchlistMovies.map({ $0.dictionaryCopy() })
        
        UserDefaults.standard.set(movieDictionaries, forKey: kWatchlistMovies)
    }
    
    static func loadFromUserDefaults() {
        
        if let movieDictionaries = UserDefaults.standard.object(forKey: kWatchlistMovies) as? [[String: AnyObject]] {
            
            MovieController.sharedController.watchlistMovies = movieDictionaries.flatMap({ Movie(jsonDictionary: $0) })
        }
    }
}

















































