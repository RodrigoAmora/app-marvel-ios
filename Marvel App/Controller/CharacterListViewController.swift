//
//  CharacterListViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
import UIKit
import MaterialComponents.MaterialButtons

class CharacterListViewController : BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Atributes
    private var characterList: [Character] = []
    private lazy var characterViewModel: CharacterViewModel = CharacterViewModel()
    private let fab = MDCFloatingButton(shape: .default)
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CharacterListViewController")
        self.configureNavBarAndSearchBar()
        self.configureFloatingButton()
        self.configureTableView()
        self.getCharacters()
    }
 
    // MARK: - Methods
    private func configureFloatingButton() {
        let widwonWidth = UIScreen.main.bounds.width - 50 - 25
        let windowHeight = UIScreen.main.bounds.height - 50 - 25
        
        fab.frame = CGRect(x: widwonWidth, y: windowHeight, width: 50, height: 50)
        fab.backgroundColor = .blue
        fab.setImage( UIImage(named: "ic_search"), for: .normal)
        fab.addTarget(self, action: #selector(showSearchView), for: .touchUpInside)
        
        self.view.addSubview(fab)
    }
    
    private func configureTableView() {
        characterTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
    }
    
    private func configureNavBarAndSearchBar() {
        navBar.topItem?.title = String(localized: "app_name")
        navBar.backgroundColor = UIColor.blue
        
        searchBar.delegate = self
        searchBar.showsLargeContentViewer = true
        searchBar.isHidden = true
        searchBar.placeholder = String(localized: "search_character_by_name")
    }
    
    private func getCharacters() {
        characterViewModel.getCharacters(completion: { resource in
            if resource.errorCode != nil && resource.errorCode ?? 0 > 0 {
                self.showError(errorCode: resource.errorCode ?? 0)
            }
            
            guard let list = resource.result else { return }
            if (list?.count == 0) {
                self.showError(errorCode: resource.errorCode ?? 0)
            } else {
                guard let list = resource.result else { return }
                self.characterList = list ?? []
                self.characterTableView.reloadData()
            }
        })
    }
    
    private func getCharactersByName(name: String) {
        let nameCharacter = searchBar.text ?? ""
        characterViewModel.getCharactersByName(name: nameCharacter, completion: { [weak self] resource in
            if resource.errorCode != nil && resource.errorCode ?? 0 > 0 {
                self?.showError(errorCode: resource.errorCode ?? 0)
            }
            
            guard let list = resource.result else { return }
            if (list?.count == 0) {
                self?.showAlert(title: "", message: String(localized: "error_no_characters"))
            } else {
                guard let list = resource.result else { return }
                self?.characterList = list ?? []
                self?.characterTableView.reloadData()
                self?.searchBar.isHidden = true
            }
        })
    }
    
    @objc func showSearchView() {
        if searchBar.isHidden {
            searchBar.isHidden = false
        } else {
            searchBar.isHidden = true
        }
    }
    
}

extension CharacterListViewController: UITableViewDataSource {
    // MARK: - UITableViewDataSource
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
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}

extension CharacterListViewController: UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character: Character = characterList[indexPath.row]
        let characterViewController = CharacterViewController.intanciate(character)
        characterViewController.modalPresentationStyle = .automatic
        
        //present(characterViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(characterViewController, animated: true)
    }
    
}

extension CharacterListViewController: CharacterTableViewCellDelegate {
    
}

extension CharacterListViewController: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let nameCharacter = searchBar.text ?? ""
        getCharactersByName(name: nameCharacter)
    }
}
