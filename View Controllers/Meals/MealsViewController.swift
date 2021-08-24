//
//  MealsViewController.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/24/21.
//

import UIKit

class MealsViewController: UIViewController {

    @IBOutlet weak var mealCategoryCollectionView: UICollectionView!
    
    var categories: [MealCategories] = []
    private let cellIdentifier = "CategoryCell"
    private let network = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealCategoryCollectionView.delegate = self
        mealCategoryCollectionView.dataSource = self
        
        

    }
    

}

extension MealsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MealsCollectionViewCell
//        cell.category = category
        return cell
    }
}

extension MealsViewController: UICollectionViewDelegate {
    
}
