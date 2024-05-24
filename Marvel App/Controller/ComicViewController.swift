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
    
    // MARK: - Methods
    private func configureNavigationBar() {
        self.navigationItem.title = String(localized: "app_name")
        
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = .cyan
        self.navigationController?.navigationBar.topItem?.title = String(localized: "back")
    }
    
    private func initViews() {
        guard let photoComicURL = self.comic?.thumbnail?.formatURL() else { return }
        self.imageComicImageView.loadImageFromURL(photoComicURL)
        
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = self.comic?.title
        
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.textColor = .black
        self.descriptionLabel.sizeToFit()
        
        guard let comicDescription = self.comic?.comicDescription else { return }
        if comicDescription.isEmpty {
            self.descriptionLabel.text = String(localized: "comic_no_description")
        } else {
            self.descriptionLabel.text = self.comic?.comicDescription
        }
    }
}
