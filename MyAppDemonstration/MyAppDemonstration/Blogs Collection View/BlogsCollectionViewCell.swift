//
//  BlogsCollectionViewCell.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import UIKit
import Kingfisher

class BlogsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var blogDescription: UILabel!
    
    var photoBlogs: Photos! {
        didSet{
            self.blogDescription.text = photoBlogs.alt_description ?? "no description"
            guard let url = URL (string: photoBlogs.urls.thumb) else {
                return
            }
            self.imageThumb.kf.setImage(with: url)
        }
    }
}
