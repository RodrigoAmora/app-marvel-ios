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
    private lazy var characterService: CharacterService = CharacterService()
    private var characterDelegate: CharacterDelegaate
    private var resource: Resource<[Character]?>?
    
    // MARK: - init
    init(characterDelegate: CharacterDelegaate) {
        self.characterDelegate = characterDelegate
    }
    
    // MARK: - Methods
    func getCharacters(offset: Int) {
        getCharacters(offset: offset, completion: { [weak self] resource in
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
    
    
    private func getCharacters(offset: Int, completion: @escaping(_ resource: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        resource = Resource(result: [Character]())
        
        characterService.getCharacters(offset: offset, completion: { [weak self] characterResponse, error in
            let characters: [Character] = characterResponse.data?.results ?? []

            if characters.count == 0 {
                completion(Resource(result: nil, errorCode: error))
            } else {
                completion(Resource(result: characters))
            }
        })
        
        return resource
    }
    
    func getCharactersByName(_ name: String) {
        getCharactersByName(name: name, completion: { [weak self] resource in
            guard let characters: [Character] = resource.result ?? [] else { return }

            if characters.count == 0 {
                self?.characterDelegate.showError(resource.errorCode ?? 0)
            } else {
                self?.characterDelegate.replaceAll(characters: characters)
            }
        })
    }
    
    private func getCharactersByName(name: String, completion: @escaping(_ characterResponse: Resource<[Character]?>) -> Void) {
        characterService.getCharactersByName(name: name, completion: { [weak self] characterResponse, error in
            let characters: [Character] = characterResponse.data?.results ?? []
            
            if characters.count == 0 {
                completion(Resource(result: nil, errorCode: error))
            } else {
                completion(Resource(result: characters))
            }
        })
    }
}

