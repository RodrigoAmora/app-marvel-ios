//
//  CharacterViewModel.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation
import CoreData
import UIKit
import Network

class CharacterViewModel {
    
    // MARK: - Atributes
    private lazy var characterRepository = CharacterRepository()
    private var characterDelegate: CharacterDelegate
    private var resource: Resource<[Character]?>?
    
    // MARK: - init
    init(characterDelegate: CharacterDelegate) {
        self.characterDelegate = characterDelegate
    }
    
    // MARK: - Methods
    func getCharacters(offset: Int) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connection is available.")
                self.characterRepository.getCharacters(offset: offset, completion: { [weak self] resource in
                    guard let characters: [Character] = resource.result ?? [] else { return }
                    self?.characterDelegate.populateTableView(characters: characters)
                })
            } else {
                print("Internet connection is not available.")
                let characters = self.characterRepository.getCharactersFromDataBase()
                self.characterDelegate.populateTableView(characters: characters)
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func getCharactersByName(_ name: String) {
        self.characterRepository.getCharactersByName(name: name, completion: { [weak self] resource in
            guard let characters: [Character] = resource.result ?? [] else { return }

            let errorCode = resource.errorCode
            if errorCode != nil {
                self?.characterDelegate.showError(errorCode ?? 0)
            } else {
                self?.characterDelegate.replaceAll(characters: characters)
            }
        })
    }
    
}
