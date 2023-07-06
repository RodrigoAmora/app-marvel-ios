//
//  CharacterViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 29/06/23.
//

import Foundation
import UIKit

class CharacterViewController: BaseViewController {
 
    // MARK: - IBOutlets
    @IBOutlet weak var nameCharaterLabel: UILabel!
    @IBOutlet weak var descriptionCharaterLabel: UILabel!
    @IBOutlet weak var imageCharaterImageView: UIImageView!
//    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Atributes
    private var character: Character?
    
    // MARK: - init
    class func intanciate(_ character: Character) -> CharacterViewController {
        let controller = CharacterViewController()
        controller.character = character
        
        return controller
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CharacterViewController")
        self.configureNavigationBar()
        self.initView()
    }
    
    private func configureNavigationBar() {
//        navBar.topItem?.title = String(localized: "app_name")
//        navBar.backgroundColor = UIColor.blue
//
//        navBar.backItem?.title = "cdnjjdbjdb"
        navigationItem.backBarButtonItem?.title = "hghghgh"
    }
    
    private func initView() {
        let photoCharacterURL = (character?.thumbnail?.path ?? "")+"."+(character?.thumbnail?.extensionPhoto ?? "")
        imageCharaterImageView.loadImageFromURL(photoCharacterURL)
        
        nameCharaterLabel.textAlignment = .center
        nameCharaterLabel.textColor = .black
        nameCharaterLabel.text = character?.name
        
        descriptionCharaterLabel.textColor = .black
        descriptionCharaterLabel.text = character?.characterDescription
    }
}
