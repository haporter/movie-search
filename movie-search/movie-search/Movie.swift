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
    private let kRating = "vote_average"
    
    let title: String
    let overview: String
    let posterPath: String?
    let rating: Float
    
    init(title: String, overview: String, posterPath: String?, rating: Float) {
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.rating = rating
    }
    
    init?(jsonDictionary: [String: AnyObject]) {
        guard let title = jsonDictionary[kTitle] as? String,
            overview = jsonDictionary[kOverview] as? String,
            voteAverage = jsonDictionary[kRating] as? Float else { return nil }
        
        self.title = title
        self.overview = overview
        self.posterPath = jsonDictionary[kPosterPath] as? String
        self.rating = voteAverage
    }
}

/// Conform to Equatable protocol

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return (lhs.title == rhs.title) && (lhs.overview == rhs.overview) && (lhs.rating == rhs.rating)
}