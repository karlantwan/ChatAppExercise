//
//  BlogPostViewController.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/16/21.
//

import UIKit

class BlogPostViewController: UIViewController {
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String!
    
//    static let identifier = "BlogCollectionViewCell"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.kf.setImage(with: URL(string: imageUrl))
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
