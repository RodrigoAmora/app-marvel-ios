//
//  ComicViewModel.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation

class ComicViewModel {
    
    // MARK: - Atributes
    private lazy var comicRepository = ComicRepository()
    private var comicDelegate: ComicDelegate
    private var resource: Resource<[Comic]?>?
    
    // MARK: - init
    init(comicDelegate: ComicDelegate) {
        self.comicDelegate = comicDelegate
    }
    
    // MARK: - Methods
    func getComicsByCharacterId(_ characterId: Int) {
        self.comicRepository.getComicsByCharacterId(characterId, completion: { [weak self] resource in
            guard let comics: [Comic] = resource.result ?? [] else { return }
            self?.comicDelegate.update(comics: comics)
        })
    }
}
