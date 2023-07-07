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
    //private lazy var characterRepository: CharacterRepository = CharacterRepository()
    private lazy var characterService: CharacterService = CharacterService()
    private var characterProtocol: CharacterProtocol
    private var resource: Resource<[Character]?>?
    
    init(characterProtocol: CharacterProtocol) {
        self.characterProtocol = characterProtocol
    }
    
    // MARK: - Methods
    func getCharacters(offset: Int, completion: @escaping(_ resource: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        resource = Resource(result: characterDao.recovery())
        
        characterService.getCharacters(offset: offset, completion: { [weak self] characterResponse, error in
            //guard let charaters: [Character] = resource?.result else { return [] }
            let charaters: [Character] = characterResponse.data?.results ?? []
            
            if charaters.count == 0 {
                self?.characterProtocol.showError(error ?? 0)
            } else {
                self?.characterDao.save(charaters)
                self?.resource?.result = charaters
                self?.characterProtocol.populateTableView(characters: charaters)
            }
        })
        
        return resource
    }
    
    func getCharacters() -> Resource<[Character]?>? {
        resource = Resource(result: characterDao.recovery())
        return resource
    }
    
    func getCharactersByName(name: String, completion: @escaping(_ characterResponse: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
//        characterService.getCharactersByName(name: name, completion: { [weak self] resource in
//            completion(resource)
//        })
        return resource
    }
    
}

