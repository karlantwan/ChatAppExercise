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
    @IBOutlet weak var collectionView: UICollectionView!
    private let network = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Gallery"

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        
        network.fetch(resource: "photos", model: Photos.self) { results in
            self.photos = results as! [Photos]
            self.collectionView.reloadData()
            print(results)
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

//extension GalleryViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize (width: screenSize.size.width, height: 220)
//    }
//}


