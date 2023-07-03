//
//  CharacterViewModel.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation

class CharacterViewModel {
    
    // MARK: - Atributes
    private lazy var characterRepository: CharacterRepository = CharacterRepository()
    private var resource: Resource<[Character]?>?
    
    // MARK: - Methods
    func getCharacters(completion: @escaping(_ characterResponse: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        characterRepository.getCharacters(completion: { [weak self] resource in
            completion(resource)
        })
        
        return resource
    }
    
    func getCharactersByName(name: String, completion: @escaping(_ characterResponse: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        characterRepository.getCharactersByName(name: name, completion: { [weak self] resource in
            completion(resource)
        })
    }
    
}

