//
//  RegisterViewController.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/17/21.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {

    @IBOutlet weak var continueToLoginButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerTapped: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var houseNumberTextField: UITextField!
    @IBOutlet weak var barangayTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.setNavigationBarHidden(false, animated: true)
//        confirmPasswordTextField.isHidden = true
    }
    
    func setUpElements (){
        
        AppUI.styleFilledButton(registerTapped)
        self.errorLabel.alpha = 0
        continueToLoginButton.isHidden = true
    }
    
    //Check the fields and validate that data us correct. If everything is correct, yhis method returns nil. Otherwise, it returns the error message
    
    func validateFields() -> String? {
        //check that all fields are field
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
         {
            
            return "Please fill in the fields"
        }
        
        if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) !=  confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
        showError(_message: "Password do not match") 
                }
     
        return nil
    }
    @IBAction func registerTapped(_ sender: Any) {
    
        
        // Validate Fields
        let error = validateFields()
        
        if error != nil {
            //There's an error with the fields, show error message
            showError(_message: "Fill in all fields")
        }
        else {
            //Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let address = "\(houseNumberTextField.text!), \(barangayTextField.text!), \(cityTextField.text!), \(zipCodeTextField.text!), \(provinceTextField.text!), \(countryTextField.text!)"
            
            // Create the User
            Auth.auth().createUser(withEmail: email, password: password){ [self](result, err) in
            // Check for err
            if err != nil{
                self.showError(_message: "Error creating user")
                print(firstName)
            }
            else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["first_name":firstName, "last_name":lastName, "email": email, "password": password, "address": address, "uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
                        // Show error message
                        self.showError(_message: "Error saving user data")
                    }
            }
                self.errorLabel.alpha = 1
                self.errorLabel.textColor = UIColor.systemGreen
                self.errorLabel.text = "Successfully created an account"
                
                
                continueToLoginButton.isHidden = false
//
//                self.transitionToLogin()
            }
                
            }
        }

    }

    func showError(_message: String) {
        errorLabel.text = _message
        errorLabel.alpha = 1
    }
    @IBAction func continueToLogin(_ sender: Any) {
        
        transitionToLogin()
    }
    
    func transitionToLogin(){
        
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
                
            }

}
