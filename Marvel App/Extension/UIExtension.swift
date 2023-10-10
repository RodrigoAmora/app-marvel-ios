//
//  UIExtension.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 06/07/23.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func configureActivityIndicatorView() {
        self.backgroundColor = .gray
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/4.0
        self.color = .blue
        self.isHidden = false
    }
    
    func hideActivityIndicatorView() {
        self.isHidden = true
    }
}

extension UIImageView {
    func loadImageFromURL(_ url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
