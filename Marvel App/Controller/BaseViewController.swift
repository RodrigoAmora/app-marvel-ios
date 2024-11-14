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
    
    func getVersionApp() -> String? {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return appVersion
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let buttonOK = UIAlertAction(title: String(localized: "button_ok"), style: .cancel)
        
        alert.addAction(buttonOK)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(errorCode: Int) {
        let message = switch errorCode {
            case 403:
                String(localized: "error_access_denied")
            case 404:
                String(localized: "error_character_not_found")
            case 500:
                String(localized: "error_service_unavailable")
            default:
                String(localized: "error_cant_was_possible_perform_operation")
        }
        
        self.showAlert(title: "", message: message)
    }
    
    func configureNavigationBarAndRightBarButtonItem() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.blue

        let textColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = textColor
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationItem.title = String(localized: "app_name")
        
    }
}
