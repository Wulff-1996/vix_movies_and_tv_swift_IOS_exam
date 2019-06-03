//
//  DiscoverViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 10/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//

class Global
{
    var entertainment = Entertainment()
}

var global = Global()

import UIKit
import Firebase
import NavigationDrawer

class DiscoverViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    let interactor = Interactor()
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var currentSelectedType: UIButton!
    
    //  fetch data from API veriables
    var entertainmentType = Constants.entertainmentTypes.MOVIES
    var category = Constants.movieCategories.POPULAR
    
    var entertainments = [Entertainment]()
    var selectedEntertainment: Entertainment?
    
    var currentPage: Int = 1
    var counter = 20
    
    //  repositories
    let movieRepo = MovieRepository()
    let tvRepo = TVRepository()
    
    var shouldBeUpdated = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.mCollectionView.delegate = self
        self.mCollectionView.dataSource = self
        
        self.currentSelectedType.titleLabel!.text = "\(self.entertainmentType) \(self.category)"        
        movieRepo.getAll(category: self.category, forPage: self.currentPage)
        { (movies) in
            self.entertainments = movies
            self.reloadCollectionView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if self.shouldBeUpdated == true
        {
            self.currentSelectedType.titleLabel?.text = "\(self.entertainmentType) \(self.category)"
            self.reloadCollectionView()
            self.scrollToTop()
            self.fetchData()
        }
        self.shouldBeUpdated = false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
       if let details = segue.destination as? DetailsViewController
        {
            details.entertainment = self.selectedEntertainment!
        }
        if let slidingPandel = segue.destination as? SlidingViewController
        {
            slidingPandel.interactor = self.interactor
            slidingPandel.discoverViewController = self
            slidingPandel.transitioningDelegate = self
        }
    }
    
    
    func reloadCollectionView()
    {
        DispatchQueue.main.async{self.mCollectionView.reloadData()}
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
        self.mCollectionView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func resetMoviesAndTvs()
    {
        self.entertainments.removeAll()
    }
    
    func fetchData()
    {
        if self.entertainmentType == Constants.entertainmentTypes.MOVIES
        {
            self.movieRepo.getAll(category: self.category, forPage: self.currentPage, completion:
                { (movies) in
                    self.entertainments.append(contentsOf: movies)
                    self.reloadCollectionView()
            })
        }
        else if entertainmentType == Constants.entertainmentTypes.TV
        {
            self.tvRepo.getAll(category: self.category, forPage: self.currentPage, completion:
                { (tvs) in
                    self.entertainments.append(contentsOf: tvs)
                    self.reloadCollectionView()
            })
        }
    }
    
    
    ///////////////   Collectionview  //////////
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       return self.entertainments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! MovieCell
        
        //  see if the next page is reached
        updatePage(row: indexPath.row)
        
        // Configure the cell
        if let path = entertainments[indexPath.row].posterPath
        {
            if !path.isEmpty
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
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.selectedEntertainment = self.entertainments[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    ////////// Button actions   ////////////////
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "showMenu", sender: nil)
    }
    
    //Pan Gesture to slide the menu from Certain Direction
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer)
    {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor)
        {
                self.performSegue(withIdentifier: "showMenu", sender: nil)
        }
    }
}



extension DiscoverViewController: UIViewControllerTransitioningDelegate
{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return interactor.hasStarted ? interactor : nil
    }
}
