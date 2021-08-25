//
//  MealsCollectionViewCell.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/24/21.
//

import UIKit

class MealsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
//
//    static let identifier = "MealCollectionViewCell"

    var list: [MealCategory]! {
        didSet{
            self.categoryLabel.text = list
            }
        }
    }

