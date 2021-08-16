//
//  FullScreenImageViewController.swift
//  MyAppDemonstration
//
//  Created by OPSolutions PH on 8/12/21.
//

import UIKit
import Kingfisher

class FullScreenImageViewController: UIViewController {
    
    var imageUrl: String!

    @IBOutlet weak var fullScreenImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullScreenImage.kf.setImage(with: URL(string: imageUrl))
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

}

