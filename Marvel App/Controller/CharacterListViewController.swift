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
    private var characters: [Character] = []
    private lazy var characterViewModel: CharacterViewModel = CharacterViewModel(characterProtocol: self)
    private var fab: MDCFloatingButton!
    private let refreshControl = UIRefreshControl()
    
    
    private var offset = 0
    
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
        
        fab = MDCFloatingButton(frame: CGRect(x: widwonWidth, y: windowHeight, width: 50, height: 50))
        fab.backgroundColor = .blue
        fab.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        fab.addTarget(self, action: #selector(showSearchView), for: .touchUpInside)
        
        self.view.addSubview(fab)
    }
    
    private func configureTableView() {
        characterTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        characterTableView.isScrollEnabled = true
        characterTableView.remembersLastFocusedIndexPath = true
        
        
        refreshControl.addTarget(self, action: #selector(paginateTableView), for: .valueChanged)
        characterTableView.refreshControl = refreshControl
        refreshControl.endRefreshing()
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
        characterViewModel.getCharacters(offset: offset, completion: { resource in })
    }
    
    @objc private func paginateTableView() {
        offset += 20
        getCharacters()
        //refreshControl.endRefreshing()
    }
    
    private func getCharactersByName(name: String) {
        let nameCharacter = searchBar?.text?.replacingOccurrences(of: " ", with: "%20") ?? ""
        characterViewModel.getCharactersByName(name: nameCharacter, completion: { [weak self] resource in})
    }
    
    @objc func showSearchView() {
        if searchBar.isHidden {
            searchBar.isHidden = false
        } else {
            searchBar.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("error creating CharacterTableViewCell")
        }

        let character = characters[indexPath.row]
        cell.configureCell(character)
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count-1 {
            paginateTableView()
            let targetRonIdexPath = IndexPath(row: indexPath.row-5, section: 0)
            characterTableView.scrollToRow(at: targetRonIdexPath, at: .middle, animated: false)
        }
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character: Character = characters[indexPath.row]
        let characterViewController = CharacterViewController.intanciate(character)
        characterViewController.modalPresentationStyle = .automatic
        
        self.changeViewControllerWithPushViewController(characterViewController)
    }
}

// MARK: - UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let nameCharacter = searchBar.text ?? ""
        getCharactersByName(name: nameCharacter)
    }
}

// MARK: - CharacterDelegaate
extension CharacterListViewController: CharacterDelegaate {
    func populateTableView(characters: [Character]) {
        self.characters = characters
        self.characterTableView.reloadData()
        self.searchBar.isHidden = true
    }
    
    func showError(_ errorCode: Int) {
        self.showError(errorCode: errorCode)
    }
}
