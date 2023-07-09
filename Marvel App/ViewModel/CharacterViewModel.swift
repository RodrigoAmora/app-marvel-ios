//
//  CharacterViewModel.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation

class CharacterViewModel {
    
    // MARK: - Atributes
    private lazy var characterDao: CharacterDao = CharacterDao()
    private lazy var characterService: CharacterService = CharacterService()
    private var characterDelegate: CharacterDelegaate
    private var resource: Resource<[Character]?>?
    
    // MARK: - init
    init(characterDelegate: CharacterDelegaate) {
        self.characterDelegate = characterDelegate
    }
    
    // MARK: - Methods
    func getCharacters(offset: Int) {
        let charactersFomDatabase = characterDao.recovery()
        if !charactersFomDatabase.isEmpty {
            characterDelegate.populateTableView(characters: charactersFomDatabase)
        }
        
        getCharacters(offset: offset, completion: { [weak self] resource in
            guard let characters: [Character] = resource.result ?? [] else { return }

            if characters.count == 0 {
                self?.characterDelegate.showError(resource.errorCode ?? 0)
            } else {
                self?.characterDao.save(characters)
                self?.characterDelegate.populateTableView(characters: characters)
            }
        })
    }
    
    
    private func getCharacters(offset: Int, completion: @escaping(_ resource: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        resource = Resource(result: characterDao.recovery())
        
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
                self?.characterDao.save(characters)
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

