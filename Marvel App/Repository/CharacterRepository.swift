//
//  CharacterRepository.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 28/11/23.
//

import Foundation

class CharacterRepository {
    
    // MARK: - Atributes
    private lazy var characterService: CharacterService = CharacterService()
    private var resource: Resource<[Character]?>?
    
    // MARK: - Methods
    func getCharacters(offset: Int, completion: @escaping(_ resource: Resource<[Character]?>) -> Void) -> Resource<[Character]?>? {
        self.resource = Resource(result: [Character]())
        self.resource?.result = CharacterDao.findCharacters()
        
        self.characterService.getCharacters(offset: offset, completion: { [weak self] characterResponse, error in
            let characters: [Character] = characterResponse.data?.results ?? []

            if characters.count == 0 {
                completion(Resource(result: nil, errorCode: error))
            } else {
                self?.deleteCharacters()
                
                for character in characters {
                    self?.saveCharactersFromDataBase(character)
                }
                
                completion(Resource(result: characters))
            }
        })
        
        return self.resource
    }
 
    func getCharactersByName(name: String, completion: @escaping(_ characterResponse: Resource<[Character]?>) -> Void) {
        self.characterService.getCharactersByName(name: name, completion: { [weak self] characterResponse, error in
            let characters: [Character] = characterResponse.data?.results ?? []
            
            if error != nil {
                completion(Resource(result: nil, errorCode: error))
            } else {
                completion(Resource(result: characters))
            }
        })
    }
    
    func getCharactersFromDataBase() -> [Character] {
        return CharacterDao.findCharacters()
    }
    
    private func saveCharactersFromDataBase(_ character: Character) {
        ThumbnailDao.save(character.thumbnail!)
        CharacterDao.save(character)
    }
    
    private func deleteCharacters() {
        CharacterDao.cleanCoreData()
    }
}
