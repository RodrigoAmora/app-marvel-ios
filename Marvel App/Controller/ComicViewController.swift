//
//  ComicViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation
import UIKit

class ComicViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageComicImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Atributes
    private var comic: Comic?
    
    // MARK: - init
    class func intanciate(_ comic: Comic) -> ComicViewController {
        let controller = ComicViewController()
        controller.comic = comic
        
        return controller
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        self.configureNavigationBar()
        self.initViews()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = String(localized: "app_name")
        
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = .cyan
        self.navigationController?.navigationBar.topItem?.title = String(localized: "back")
    }
    
    private func initViews() {
        let photoComicURL = (comic?.thumbnail?.path)!+"."+(comic?.thumbnail?.extensionPhoto)!
        imageComicImageView.loadImageFromURL(photoComicURL)
        
        titleLabel.textAlignment = .center
        titleLabel.text = comic?.title
        
        if (comic!.description.isEmpty) {
            descriptionLabel.text = String(localized: "character_no_description")
        } else {
            descriptionLabel.textColor = .black
            descriptionLabel.text = comic?.comicDescription
        }
    }
}
