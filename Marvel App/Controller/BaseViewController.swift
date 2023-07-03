//
//  BaseViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let buttonOK = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(buttonOK)
        present(alert, animated: true, completion: nil)
    }
    
}
