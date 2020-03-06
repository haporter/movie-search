//
//  Movie.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

struct Movie: Equatable {
    
    fileprivate let kTitle = "title"
    fileprivate let kOverview = "overview"
    fileprivate let kPosterPath = "poster_path"
    fileprivate let kBackDropPath = "backdrop_path"
    fileprivate let kRating = "vote_average"
    
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Float
    
    // Storing the images on the model to help improve scrolling in collectionViews and tableViews
    var posterImage: UIImage?
    var backdropImage: UIImage?
    
    init(title: String, overview: String, posterPath: String?, backDropPath: String?, rating: Float) {
        self.title = title
        self.overview = overview
        self.poster_path = posterPath
        self.backdrop_path = backDropPath
        self.vote_average = rating
    }
    
    init?(jsonDictionary: [String: AnyObject]) {
        guard let title = jsonDictionary[kTitle] as? String,
            let overview = jsonDictionary[kOverview] as? String,
            let voteAverage = jsonDictionary[kRating] as? Float else { return nil }
        
        self.title = title
        self.overview = overview
        
        if let poster_path = jsonDictionary[kPosterPath] as? String {
            self.poster_path = poster_path
            self.posterImage = UIImage(data: try! Data(contentsOf: URL(string: "http://image.tmdb.org/t/p/w500\(poster_path)")!))
        } else {
            self.poster_path = jsonDictionary[kPosterPath] as? String
        }
        
        if let backdrop_path = jsonDictionary[kBackDropPath] as? String {
            self.backdrop_path = backdrop_path
            self.backdropImage = UIImage(data: try! Data(contentsOf: URL(string: "http://image.tmdb.org/t/p/w500\(backdrop_path)")!))
        } else {
            self.backdrop_path = jsonDictionary[kBackDropPath] as? String
        }
        
        self.vote_average = voteAverage
        
    }
    
    func dictionaryCopy() -> [String: AnyObject] {
        
        var movieDictionary: [String: AnyObject] = [kTitle: self.title as AnyObject,
                                                    kOverview: self.overview as AnyObject,
                                                    kRating: vote_average as AnyObject]
        if let poster_path = self.poster_path {
            movieDictionary[kPosterPath] = poster_path as AnyObject
        }
        
        if let backdrop_path = self.backdrop_path {
            movieDictionary[kBackDropPath] = backdrop_path as AnyObject
        }
        
        return movieDictionary
    }
}

/// Conform to Equatable protocol

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return (lhs.title == rhs.title) && (lhs.overview == rhs.overview) && (lhs.vote_average == rhs.vote_average)
}
