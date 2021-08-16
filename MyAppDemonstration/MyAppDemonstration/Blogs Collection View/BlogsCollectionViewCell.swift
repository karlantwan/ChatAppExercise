//
//  BlogsCollectionViewCell.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import UIKit
import Kingfisher

class BlogsCollectionViewCell: UICollectionViewCell {
    
    var photo: Photos! {
        didSet{
            self.photoDescription.text = photo.alt_description ?? "no description"
            guard let url = URL (string: photo.urls.thumb) else {
                return
            }
            self.imageCell.kf.setImage(with: url)
        }
    }
}
