//
//  ComicViewModel.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation

class ComicViewModel {
    
    // MARK: - Atributes
    private lazy var characterDao: CharacterDao = CharacterDao()
    private lazy var characterService: CharacterService = CharacterService()
    private var comicDelegate: ComicDelegate
    private var resource: Resource<[Comic]?>?
    
    // MARK: - init
    init(comicDelegate: ComicDelegate) {
        self.comicDelegate = comicDelegate
    }
    
    func getComicsByCharacterId(_ characterId: Int) {
        getComicsByCharacterId(characterId, completion: { [weak self] resource in
            guard let comics: [Comic] = resource.result ?? [] else { return }
            self?.comicDelegate.update(comics: comics)
            
//            if comics.count == 0 {
//                self?.comicDelegate.showError(resource.errorCode ?? 0)
//            } else {
//                self?.comicDelegate.update(comics: comics)
//            }
        })
    }
    
    private func getComicsByCharacterId(_ characterId: Int, completion: @escaping(_ comicResponse: Resource<[Comic]?>) -> Void) {
        characterService.getComicsByCharacterId(characterId, completion: { [weak self] comicResponse, error in
            let comics: [Comic] = comicResponse.data?.results ?? []
            
            if comics.count == 0 {
                completion(Resource(result: nil, errorCode: error))
            } else {
                completion(Resource(result: comics))
            }
        })
    }
}
