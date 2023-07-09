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
        self.navigationItem.title = String(localized: "app_name")
        
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = .cyan
        self.navigationController?.navigationBar.topItem?.title = String(localized: "back")
    }
    
    private func initView() {
        let photoCharacterURL = (character?.thumbnail?.path ?? "")+"."+(character?.thumbnail?.extensionPhoto ?? "")
        imageCharaterImageView.loadImageFromURL(photoCharacterURL)
        
        nameCharaterLabel.textAlignment = .center
//        nameCharaterLabel.textColor = .black
        nameCharaterLabel.text = character?.name
        
        if ((character?.description.isEmpty) != nil) {
            descriptionCharaterLabel.text = String(localized: "character_no_description")
        } else {
            descriptionCharaterLabel.textColor = .black
            descriptionCharaterLabel.text = character?.characterDescription
        }
    }
}
