//
//  ViewController.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/17/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpElements (){
        
        AppUI.styleFilledButton(registerButton)
        AppUI.styleFilledButton(loginButton)
    }

}

