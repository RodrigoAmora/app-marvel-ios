//
//  ComicDelegate.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 10/07/23.
//

import Foundation

protocol ComicDelegate {
    func update(comics: [Comic])
    func replaceAll(comics: [Comic])
    func showError(_ errorCode: Int)
}
