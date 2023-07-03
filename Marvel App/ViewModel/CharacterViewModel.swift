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
    
    // MARK: - Methods
    func getCharacters() -> Resource<[Character]>? {
        return characterRepository.getCharacters()
    }
    
}
