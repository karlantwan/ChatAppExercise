//
//  ViewController.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/11/21.
//

import UIKit

class GalleryViewController: UIViewController {
    let screenSize = UIScreen.main.bounds
    let periwinkle = UIColor(red: 0xCC, green: 0xCC, blue: 0xFF, alpha: 0xFF)
    private let cellIdentifier = "ImageCell"
    private var photos: [Photos] = []
    let filterKeywords = ["1", "2", "3"]
    var currentFilterIndex = 0
    @IBAction func filterPhotos(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        currentFilterIndex = segmentedControl.selectedSegmentIndex
        loadImages()
        print(filterKeywords[currentFilterIndex])
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Gallery"

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        loadImages()
    }
    
    fileprivate func truncateTable () {
        db.truncate(tableName: "PhotoModel")
        db.truncate(tableName: "UserModel")

    }
    
    fileprivate func loadImages() {
        activityIndicator.startAnimating()
        collectionView.isHidden = true
        truncateTable()
        fetchData()
    }
    
    fileprivate func fetchData() {
        let source = PhotoSourceAPI()
        source.fetchPhotos(orderBy: filterKeywords[currentFilterIndex]) {(photos: [Photos]?, error: APIError?) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    
                    switch error {
                    case .apiFailed(let message):
                        print(message)
                    case .parsingFailed(let message):
                        print(message)
                    }
                } else {
                    if let photos = photos {
                        self.photos = photos
                        
                        for photo in self.photos {
                            db.insertData(photo)
                        }
                        
                    } else {
                        self.photos = [Photos]()
                    }
                }
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "toFullScreenImage" else {
            return
        }
        
        let fullSreenImageViewController = segue.destination as! FullScreenImageViewController
    
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
              let selectedIndexPath = selectedIndexPaths.first else {
            return
        }
        
        let photo = photos[selectedIndexPath.row]
        fullSreenImageViewController.imageUrl = photo.urls.regular
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        cell.photo = photo
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    
}



