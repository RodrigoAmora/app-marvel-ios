//
//  CharacterTableViewCell.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import UIKit

protocol CharacterTableViewCellDelegate: AnyObject {
    
}

class CharacterTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var nameCharacterLabel: UILabel!
    @IBOutlet weak var photoCharacterImageView: UIImageView!
    
    // MARK: - Atributes
    weak var delegate: CharacterTableViewCellDelegate?
    
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
        
        let photoCharacterURL = (character?.thumbnail?.path ?? "")+"."+(character?.thumbnail?.extensionPhoto ?? "")
        loadImage(from: photoCharacterURL)
    }
    
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.photoCharacterImageView.image = image
            }
        }
    }
    
}
