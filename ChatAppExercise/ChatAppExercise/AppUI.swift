//
//  AppUI.swift
//  ChatAppExercise
//
//  Created by OPSolutions PH on 8/18/21.
//

import Foundation
import UIKit

class AppUI {
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 99/255, green: 183/255, blue: 47/255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.white
    }
    
}
