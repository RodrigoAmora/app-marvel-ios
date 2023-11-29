//
//  ComicRepository.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 28/11/23.
//

import Foundation

class ComicRepository {
    
    // MARK: - Atributes
    private lazy var characterService: CharacterService = CharacterService()
    
    // MARK: - Methods
    func getComicsByCharacterId(_ characterId: Int, completion: @escaping(_ comicResponse: Resource<[Comic]?>) -> Void) {
        self.characterService.getComicsByCharacterId(characterId, completion: { [weak self] comicResponse, error in
            let comics: [Comic] = comicResponse.data?.results ?? []
            
            if comics.count == 0 {
                completion(Resource(result: nil, errorCode: error))
            } else {
                completion(Resource(result: comics))
            }
        })
    }
}
