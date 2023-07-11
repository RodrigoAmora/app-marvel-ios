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
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var comicsickerView: UIPickerView!
    
    // MARK: - Atributes
    private var character: Character!
    private var comics: [Comic] = []
    private var titles: [String] = []
    private lazy var comicViewModel: ComicViewModel = ComicViewModel(comicDelegate: self)
    
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
        self.initViews()
        self.getComicsByCharacterId()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = String(localized: "app_name")
        
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = .cyan
        self.navigationController?.navigationBar.topItem?.title = String(localized: "back")
    }
    
    private func initViews() {
        let photoCharacterURL = "\(character.thumbnail?.path).\(character.thumbnail?.extensionPhoto)"
        imageCharaterImageView.loadImageFromURL(photoCharacterURL)
        
        nameCharaterLabel.textAlignment = .center
        nameCharaterLabel.text = character.name
        
        comicsLabel.backgroundColor = .gray
        comicsLabel.text = String(localized: "comics")
        
        if character.description.isEmpty {
            descriptionCharaterLabel.text = String(localized: "character_no_description")
        } else {
            descriptionCharaterLabel.text = character.characterDescription
        }
    }
    
    private func getComicsByCharacterId() {
        comicViewModel.getComicsByCharacterId(character.id)
    }
}

// MARK: - UIPickerViewDelegate
extension CharacterViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.comics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.titles[row]
    }
}

// MARK: - UIPickerViewDataSource
extension CharacterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - ComicDelegate
extension CharacterViewController: ComicDelegate {
    func update(comics: [Comic]) {
        self.comics = comics
        for comic in self.comics {
            self.titles.append(comic.title)
        }
        comicsickerView.reloadAllComponents()
    }
    
    func replaceAll(comics: [Comic]) {}
    
    func showError(_ errorCode: Int) {}
}
