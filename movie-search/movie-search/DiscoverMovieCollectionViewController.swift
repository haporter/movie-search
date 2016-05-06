//
//  DiscoverMovieCollectionViewController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class DiscoverMovieCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = AppearanceController.movieGrey()
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGrayColor()
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.navigationItem.title = "Now Playing"
        
        /// Set cell dimensions
        let width = CGRectGetWidth(self.collectionView!.frame) / 3
        let height = width * 1.5
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)

        MovieController.nowPlayingMovies { (success) in
            if success {
                //print(MovieController.sharedController.nowPlayingMovies.first!.title)
                //print(MovieController.sharedController.nowPlayingMovies.first!.overview)
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.collectionView?.reloadData()
                })
            } else {
                print("The test failed")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - CollectionView Data Source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieController.sharedController.nowPlayingMovies.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as? MovieCollectionViewCell {
            let movie = MovieController.sharedController.nowPlayingMovies[indexPath.row]
            
            cell.movie = movie
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath)
            
            return cell
        }
        
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "discoverToDetail" {
            if let destinationViewController = segue.destinationViewController as? MovieDetailViewController, indexPaths = collectionView?.indexPathsForSelectedItems(), selectedIndexPath = indexPaths.first {
                
                let movie = MovieController.sharedController.nowPlayingMovies[selectedIndexPath.item]
                
                destinationViewController.movie = movie
            }
        }
    }

}
