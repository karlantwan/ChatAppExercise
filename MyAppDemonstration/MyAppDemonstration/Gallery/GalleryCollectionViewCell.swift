//
//  GalleryCollectionViewCell.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/11/21.
//

import UIKit
import Kingfisher

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    static let identifier = "GalleryCollectionViewCell"
    
    var photo: Photos! {
        didSet{
            self.photoDescription.text = photo.alt_description ?? "no description"
            guard let url = URL (string: photo.urls.regular) else {
                return
            }
            self.imageCell.kf.setImage(with: url)
        }
    }
}
