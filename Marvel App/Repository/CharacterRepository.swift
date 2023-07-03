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
    private var resource: Resource<[Character]?>?
    
    // MARK: - Methods
    func getCharacters(completion: @escaping(_ resource: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        characterService.getCharacters(completion: { [weak self]characterList, error in
            let characterList = characterList.data?.results ?? []
            if !(characterList.isEmpty) {
                self?.resource = Resource<[Character]?>(result: characterList, errorCode: 0)
                completion((self?.resource)!)
            } else {
                self?.resource = Resource<[Character]?>(result: nil, errorCode: error)
                completion((self?.resource)!)
            }
        })
        
        return resource
    }
    
}
