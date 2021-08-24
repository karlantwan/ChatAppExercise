//
//  ViewController.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/18/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTapped: UIButton!
    @IBOutlet weak var registerTapped: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        AppUI.styleFilledButton(loginTapped)
        AppUI.styleFilledButton(registerTapped)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
