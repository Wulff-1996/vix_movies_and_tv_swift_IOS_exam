//
//  RecommendationsCollectionViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 21/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

import UIKit

class RecommendationsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    var entertainment = Entertainment()
    
    //  repositories
    let movieRepo = MovieRepository()
    let tvRepo = TVRepository()
    
    var currentPage: Int = 1
    var counter = 20
    
    var entertainments = [Entertainment]()
    var selectedEntertainment: Entertainment?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.entertainment = global.entertainment
        fetchData()
    }
    
    func reloadCollectionView()
    {
        DispatchQueue.main.async{self.collectionView.reloadData()}
    }
    
    func resetPage()
    {
        self.currentPage = 1
        self.counter = 20
    }
    
    func updatePage(row: Int)
    {
        if row + 1 >= counter
        {
            self.currentPage += 1
            self.counter += 20
            fetchData()
        }
    }
    
    func scrollToTop()
    {
        self.collectionView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func fetchData()
    {
        if self.entertainment.type == Constants.entertainmentTypes.MOVIES
        {
            self.movieRepo.getRecommendations(id: entertainment.id!, forPage: currentPage)
            { (movies) in
                self.entertainments.append(contentsOf: movies as [Entertainment])
                self.reloadCollectionView()
            }
        }
        else if self.entertainment.type == Constants.entertainmentTypes.TV
        {
            self.tvRepo.getRecommendations(id: entertainment.id!, forPage: currentPage)
            { (tvs) in
                self.entertainments.append(contentsOf: tvs as [Entertainment])
                self.reloadCollectionView()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let details = segue.destination as? DetailsViewController
        {
            details.entertainment = self.selectedEntertainment!
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of items
        return self.entertainments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntertainmentCell
        
        //  see if the next page is reached
        updatePage(row: indexPath.row)
        
        // Configure the cell
        if let path = entertainments[indexPath.row].posterPath
        {
            let url = URL(string: "\(path)")!
            ImageService.getImage(withUrl: url)
            { image in
                cell.posterImageview.image = image
            }
        }
        else
        {
            cell.posterImageview.image = UIImage(named: "placeholderimage.jpg")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.selectedEntertainment = self.entertainments[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}
