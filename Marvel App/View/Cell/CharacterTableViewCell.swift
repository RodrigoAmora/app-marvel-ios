//
//  CharacterTableViewCell.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import UIKit

protocol CharacterTableViewCellDelegate: AnyObject {
    func deleteSalon(_ index: Int)
}

class CharacterTableViewCell: UITableViewCell {

    // MARK: - Atributes
    weak var delegate: CharacterTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Class methods
    func configureCell(_ character: Character?) {
    }
    
}
