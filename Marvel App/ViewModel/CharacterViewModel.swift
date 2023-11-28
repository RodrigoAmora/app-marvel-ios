//
//  CharacterViewModel.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation
import CoreData
import UIKit

class CharacterViewModel {
    
    // MARK: - Atributes
    private lazy var characterRepository = CharacterRepository()
    private var characterDelegate: CharacterDelegate
    private var resource: Resource<[Character]?>?
    
    // MARK: - init
    init(characterDelegate: CharacterDelegate) {
        self.characterDelegate = characterDelegate
    }
    
    // MARK: - Methods
    func getCharacters(offset: Int) {
        self.characterRepository.getCharacters(offset: offset, completion: { [weak self] resource in
            guard let characters: [Character] = resource.result ?? [] else { return }

            if characters.count == 0 {
                self?.characterDelegate.showError(resource.errorCode ?? 0)
            } else {
                let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                for character in characters {
                    print(character.name)
                    character.save(managedContext)
                }
                self?.characterDelegate.populateTableView(characters: characters)
            }
        })
    }
    
    func getCharactersByName(_ name: String) {
        self.characterRepository.getCharactersByName(name: name, completion: { [weak self] resource in
            guard let characters: [Character] = resource.result ?? [] else { return }

            if characters.count == 0 {
                self?.characterDelegate.showError(resource.errorCode ?? 0)
            } else {
                self?.characterDelegate.replaceAll(characters: characters)
            }
        })
    }
}
