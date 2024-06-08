//
//  CharacterProtocol.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 06/07/23.
//

import Foundation

protocol CharacterDelegate {
    func populateTableView(characters: [Character])
    func replaceAll(characters: [Character])
    func showError(_ errorCode: Int)
    func noInternet()
}
