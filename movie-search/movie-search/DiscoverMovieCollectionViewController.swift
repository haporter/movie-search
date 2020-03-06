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
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGray
        self.view.backgroundColor = UIColor.darkGray
        self.navigationItem.title = "Now Playing"
        
        MovieController.loadFromUserDefaults()
        
        /// Set cell dimensions
        let width = self.collectionView!.frame.width / 3
        let height = width * 1.5
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)

        MovieController.nowPlayingMovies { (success) in
            if success {
                
                DispatchQueue.main.async(execute: { 
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieController.sharedController.nowPlayingMovies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell {
            let movie = MovieController.sharedController.nowPlayingMovies[indexPath.row]
            
            cell.movie = movie
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
            
            return cell
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "discoverToDetail" {
            if let destinationViewController = segue.destination as? MovieDetailViewController, let indexPaths = collectionView?.indexPathsForSelectedItems, let selectedIndexPath = indexPaths.first {
                
                let movie = MovieController.sharedController.nowPlayingMovies[selectedIndexPath.item]
                
                destinationViewController.movie = movie
            }
        }
    }

}
