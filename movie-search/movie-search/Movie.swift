//
//  Movie.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import Foundation

struct Movie: Equatable {
    
    private let kTitle = "title"
    private let kOverview = "overview"
    private let kPosterPath = "poster_path"
    private let kBackDropPath = "backdrop_path"
    private let kRating = "vote_average"
    
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Float
    
    init(title: String, overview: String, posterPath: String?, backDropPath: String?, rating: Float) {
        self.title = title
        self.overview = overview
        self.poster_path = posterPath
        self.backdrop_path = backDropPath
        self.vote_average = rating
    }
    
    init?(jsonDictionary: [String: AnyObject]) {
        guard let title = jsonDictionary[kTitle] as? String,
            overview = jsonDictionary[kOverview] as? String,
            voteAverage = jsonDictionary[kRating] as? Float else { return nil }
        
        self.title = title
        self.overview = overview
        self.poster_path = jsonDictionary[kPosterPath] as? String
        self.backdrop_path = jsonDictionary[kBackDropPath] as? String
        self.vote_average = voteAverage
    }
    
    func dictionaryCopy() -> [String: AnyObject] {
        
        var movieDictionary: [String: AnyObject] = [kTitle: self.title,
                                                    kOverview: self.overview,
                                                    kRating: vote_average]
        if let poster_path = self.poster_path {
            movieDictionary[kPosterPath] = poster_path
        }
        
        if let backdrop_path = self.backdrop_path {
            movieDictionary[kBackDropPath] = backdrop_path
        }
        
        return movieDictionary
    }
}

/// Conform to Equatable protocol

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return (lhs.title == rhs.title) && (lhs.overview == rhs.overview) && (lhs.vote_average == rhs.vote_average)
}