//
//  GalleryCollectionViewCell.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/11/21.
//

import UIKit
import Kingfisher

class GalleryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ImageCell: UIImageView!
    @IBOutlet weak var PhotoDescription: UILabel!
    
    static let identifier = "PhotoCollectionViewCell"
    
    var photo: Photos! {
        didSet{
            self.PhotoDescription.text = photo.alt_description ?? "no description"
            guard let url = URL (string: photo.urls.regular) else {
                return
            }
            self.ImageCell.kf.setImage(with: url)
        }
    }
}
