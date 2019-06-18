//
//  DiscoverViewController.swift
//  MyMoviesIOSEksamen
//
//  Created by Jakob Wulff on 10/05/2019.
//  Copyright © 2019 Jakob Wulff. All rights reserved.
//
import UIKit
import Firebase
import NavigationDrawer

class DiscoverViewController: UIViewController
{
    let interactor = Interactor()
    @IBOutlet weak var mCollectionView: UICollectionView!
    @IBOutlet weak var currentSelectedType: UIButton!
        
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
    let userDefault = UserDefaults()
    
    var discoverDelegate: DiscoverDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.mCollectionView.delegate = self
        self.mCollectionView.dataSource = self
        
        self.entertainmentType = userDefault.string(forKey: "ENTERTAINMENT_TYPE") ?? Constants.entertainmentTypes.MOVIES
        self.category = userDefault.string(forKey: "CATEGORY") ?? Constants.movieCategories.POPULAR
        
        self.currentSelectedType.setTitle("\(self.entertainmentType) -> \(self.category)", for: .normal)
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if self.shouldBeUpdated == true
        {
            self.currentSelectedType.setTitle("\(self.entertainmentType) -> \(self.category)", for: .normal)
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
            global.entertainment = self.selectedEntertainment!
        }
        if let slidingPandel = segue.destination as? SlidingViewController
        {
            slidingPandel.interactor = self.interactor
            slidingPandel.transitioningDelegate = self
            slidingPandel.discoverDelegate = self
            slidingPandel.entertainmentType = self.entertainmentType
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
}

extension DiscoverViewController: DiscoverDelegate
{
    func didSelectEntertainmentType(entertainmentType: String)
    {
        if self.entertainmentType != entertainmentType
        {
            self.entertainmentType = entertainmentType
            shouldBeUpdated.toggle()
            resetPage()
            resetMoviesAndTvs()
            category = Constants.movieCategories.POPULAR
            userDefault.set(entertainmentType, forKey: "ENTERTAINMENT_TYPE")
            userDefault.set(Constants.movieCategories.POPULAR, forKey:"CATEGORY")
        }
    }
    
    func didSelectCategory(category: String)
    {
        if self.category != category
        {
            //  update the origin view
            self.category = category
            self.shouldBeUpdated.toggle()
            self.resetPage()
            self.resetMoviesAndTvs()
            self.userDefault.set(category, forKey: "CATEGORY")
        }
    }
}

extension DiscoverViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.entertainments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! EntertainmentCell
        
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
}

extension DiscoverViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.selectedEntertainment = self.entertainments[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let noOfCellsInRow = 3
        let size = Int((collectionView.bounds.width) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 200)
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
