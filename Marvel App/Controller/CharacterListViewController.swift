//
//  CharacterListViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
import UIKit

class CharacterListViewController : UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Atributes
    private var characterList: [Character] = []
    private lazy var characterService: CharacterService = CharacterService()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CharacterListViewController")
        self.configureTableView()
        self.getCharacters()
    }
 
    // MARK: - Methods
    private func configureTableView() {
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
    }
    
    private func getCharacters() {
        characterService.getCharacters(completion: { [weak self] characterList, error in
            let characterList = characterList.data?.results ?? []
            if !(characterList.isEmpty) {
                self?.characterList = characterList
                self?.characterTableView.reloadData()
            }
        })
    }
    
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("error creating CharacterTableViewCell")
        }

        let character = characterList[indexPath.row]
        cell.configureCell(character)
        cell.delegate = self
        
        return cell
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characterList[indexPath.row]
        /*
        let mapaViewController = MapaViewController.instanciar(salon)
        mapaViewController.modalPresentationStyle = .automatic
        
        present(mapaViewController, animated: true, completion: nil)
         */
    }
    
}

extension CharacterListViewController: CharacterTableViewCellDelegate {
    
}
