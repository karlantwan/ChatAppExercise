//
//  LoginViewController.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/17/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    
    func setUpElements(){
        AppUI.styleFilledButton(loginButton)
        errorLabel.alpha = 0
    }
    
    @IBAction func NONEEDTOLOGIN(_ sender: Any) {
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
        if error != nil{
            self.errorLabel.text = error!.localizedDescription
            self.errorLabel.alpha = 1
        }
        else {
            self.errorLabel.alpha = 1
            self.errorLabel.textColor = UIColor.systemGreen
            self.errorLabel.text = "You are logged in"
            
            self.transitionToHomeTabBar()
        }
        }
    }

    func transitionToHomeTabBar() {
        let homeTabBarViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeTabBarViewController) as? HomeTabBarViewController

        self.view.window?.rootViewController = homeTabBarViewController
        self.view.window?.makeKeyAndVisible()
    }

    
}
