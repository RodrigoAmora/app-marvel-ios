//
//  CharacterRepository.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation

class CharacterRepository {
    
    // MARK: - Atributes
    private lazy var characterService: CharacterService = CharacterService()
    private var resource: Resource<[Character]>?
    
    // MARK: - Methods
    func getCharacters() -> Resource<[Character]>? {
        characterService.getCharacters(completion: { [weak self] characterList, error in
            let characterList = characterList.data?.results ?? []
            if !(characterList.isEmpty) {
                self?.resource = Resource(result: characterList, errorCode: 0)
            } else {
                self?.resource = Resource(result: nil, errorCode: error)
            }
        })
        return self.resource
    }
    
}
