//
//  CharacterTableViewCell.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var nameCharacterLabel: UILabel!
    @IBOutlet weak var photoCharacterImageView: UIImageView!
    
    // MARK: - UITableViewCell methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameCharacterLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.nameCharacterLabel.textAlignment = .center
        
        self.photoCharacterImageView.layer.cornerRadius = photoCharacterImageView.frame.size.width / 2
        self.photoCharacterImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Class methods
    func configureCell(_ character: Character?) {
        self.nameCharacterLabel.text = character?.name
        
        guard let photoCharacterURL = character?.thumbnail?.formatURL() else { return }
        self.photoCharacterImageView.loadImageFromURL(photoCharacterURL)
    }
    
}
