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
        // Initialization code
        nameCharacterLabel.textAlignment = .center
        
        photoCharacterImageView.layer.cornerRadius = photoCharacterImageView.frame.size.width / 2
        photoCharacterImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Class methods
    func configureCell(_ character: Character?) {
        nameCharacterLabel.text = character?.name
        
        guard let photoCharacterURL = character?.thumbnail?.formatURL() else { return }
        photoCharacterImageView.loadImageFromURL(photoCharacterURL)
    }
    
}
