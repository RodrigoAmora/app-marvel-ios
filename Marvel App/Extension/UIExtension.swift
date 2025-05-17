//
//  UIExtension.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 06/07/23.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func configureAndHide() {
        self.configure()
        self.hide()
    }
    
    func configure() {
        self.backgroundColor = .gray
        self.color = .blue
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/4.0
    }
    
    func hide() {
        self.isHidden = true
        self.stopAnimating()
    }
    
    func show() {
        self.isHidden = false
        self.startAnimating()
    }
}

extension UIImageView {
    private func roundedCorners() {
        self.backgroundColor = .blue
        self.clipsToBounds = true
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func roundedImage() {
        self.roundedCorners()
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = bounds.height / 5
    }
    
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

extension UISearchBar {
    func posY() {
        let searchBarPosY: CGFloat = switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                75
            
            case .phone:
                95
            
            default:
                85
        }
        
        self.frame.origin.y = searchBarPosY
    }
}
