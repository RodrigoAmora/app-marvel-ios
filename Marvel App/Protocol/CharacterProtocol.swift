//
//  CharacterProtocol.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 06/07/23.
//

import Foundation

protocol CharacterProtocol {
    func populateTableView(characters: [Character])
    func showError(_ errorCode: Int)
}
