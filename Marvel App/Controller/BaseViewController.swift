//
//  BaseViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func changeViewControllerWithPresent(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func changeViewControllerWithPushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let buttonOK = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(buttonOK)
        present(alert, animated: true, completion: nil)
    }
    
    func showError(errorCode: Int) {
        switch errorCode {
            case 403:
                showAlert(title: "", message: String(localized: "error_access_denied"))
                break
            case 500:
                showAlert(title: "", message: String(localized: "error_service_unavailable"))
                break
            default:
                showAlert(title: "", message: String(localized: "error_cant_was_possible_perform_operation"))
                break
        }
    }
    
}
