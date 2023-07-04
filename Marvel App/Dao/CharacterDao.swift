//
//  CharacterDao.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 03/07/23.
//

import Foundation

class CharacterDao {

    func save(_ characters: [Character]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: characters, requiringSecureCoding: false)
            guard let path = recoveryDirectory() else { return }
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recovery() -> [Character] {
        do {
            guard let directory = recoveryDirectory() else { return [] }
            let data = try Data(contentsOf: directory)
            let charactersSaved = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Character]
            return charactersSaved
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recoveryDirectory() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = directory.appendingPathComponent("characters")
        
        return path
    }
    
}
