//
//  ThumbnailDao.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 09/07/23.
//

import Foundation

class ThumbnailDao {
    
    func save(_ thumbnails: [Thumbnail]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: thumbnails, requiringSecureCoding: false)
            guard let path = recoveryDirectory() else { return }
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recovery() -> [Thumbnail] {
        do {
            guard let directory = recoveryDirectory() else { return [] }
            let data = try Data(contentsOf: directory)
            let thumbnailsSaved = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Thumbnail]
            return thumbnailsSaved
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recoveryDirectory() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = directory.appendingPathComponent("thumbnails")
        
        return path
    }
    
}
