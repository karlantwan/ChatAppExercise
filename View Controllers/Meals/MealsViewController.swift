//
//  MealsViewController.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/24/21.
//

import UIKit

class MealsViewController: UIViewController {

    @IBOutlet weak var mealCategoryCollectionView: UICollectionView!
    
    var categoryList = MealCategory(categories: [])
    private let cellIdentifier = "CategoryCell"
    private let network = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealCategoryCollectionView.delegate = self
        mealCategoryCollectionView.dataSource = self
        fetchCategories()
        

    }
    
    func fetchCategories(){
        let source = MealSourceAPI()
        source.fetchMealCategories(orderBy: APIEndpoints.categories) {(categories: MealCategory?, error: APIError?) in
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
                    if let ctgry = categories {
                        self.categoryList = ctgry
                        print ("categories = \(self.categoryList.categories.count)")
                        
                    } else {
                        self.categoryList = MealCategory(categories: [])
                    }
//                self.mealCategoryCollectionView.isHidden = false
//                self.mealCategoryCollectionView.reloadData()
                }
            }
        }
    }
}

func  fetchAllMeals() {
    
}

extension MealsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryList.categories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MealsCollectionViewCell
        cell.list = category
        return cell
    }
}

extension MealsViewController: UICollectionViewDelegate {
    
}

