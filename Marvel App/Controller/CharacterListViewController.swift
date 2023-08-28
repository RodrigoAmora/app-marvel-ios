//
//  CharacterListViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
import UIKit
import MaterialComponents.MaterialButtons
import CoreData

class CharacterListViewController : BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Atributes
    private var characters: [Character] = []
    private lazy var characterViewModel: CharacterViewModel = CharacterViewModel(characterDelegate: self)
    private var fab: MDCFloatingButton!
    private let refreshControl = UIRefreshControl()
    private var offset = 0
    
    let searcher: NSFetchedResultsController<Character> = Character.getSearcher()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CharacterListViewController")
        self.configureNavBarAndSearchBar()
        self.configureFloatingButton()
        self.configureTableView()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        Character.load(searcher)
        characters = searcher.fetchedObjects!
        characterTableView.reloadData()
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
        self.navigationItem.title = String(localized: "app_name")
        
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = .cyan
        
        searchBar.delegate = self
        searchBar.showsLargeContentViewer = true
        searchBar.isHidden = true
        searchBar.placeholder = String(localized: "search_character_by_name")
    }
    
    private func getCharacters() {
        characterViewModel.getCharacters(offset: offset)
    }
    
    private func getCharactersByName(_ name: String) {
        characterViewModel.getCharactersByName(name)
    }
    
    private func viewDetailsOfCharacter(_ character: Character) {
        let characterViewController = CharacterViewController.intanciate(character)
        characterViewController.modalPresentationStyle = .automatic
        
        self.changeViewControllerWithPushViewController(characterViewController)
    }
    
    @objc private func paginateTableView() {
        offset += 20
        getCharacters()
        refreshControl.endRefreshing()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favouriteaction = UIContextualAction(style: .normal, title: String(localized: "view_details")) {
            [weak self] (action, view, completionHandler) in
            guard let character: Character = self?.characters[indexPath.row] else { return }
            self?.viewDetailsOfCharacter(character)
            completionHandler(true)
        }
        favouriteaction.backgroundColor = .systemGray
        
        return UISwipeActionsConfiguration(actions: [favouriteaction])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count-1, characters.count >= 20 {
            paginateTableView()
        }
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        characterTableView.deselectRow(at: indexPath, animated: true)
        
        let character: Character = characters[indexPath.row]
        self.viewDetailsOfCharacter(character)
    }
}

// MARK: - UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let nameCharacter = searchBar.text?.replacingOccurrences(of: " ", with: "%20") ?? ""
        getCharactersByName(nameCharacter)
    }
}

// MARK: - CharacterDelegaate
extension CharacterListViewController: CharacterDelegate {
    func populateTableView(characters: [Character]) {
        self.characters = characters
        self.characterTableView.reloadData()
        
        if offset != 0 {
            let targetRonIdexPath = IndexPath(row: self.characters.count-5, section: 0)
            characterTableView.scrollToRow(at: targetRonIdexPath, at: .middle, animated: false)
        }
    }
    
    func replaceAll(characters: [Character]) {
        self.characters.removeAll()
        self.characters = characters
        self.characterTableView.reloadData()
        self.searchBar.isHidden = true
        
        if characters.count > 10 {
            let targetRonIdexPath = IndexPath(row: 0, section: 0)
            characterTableView.scrollToRow(at: targetRonIdexPath, at: .top, animated: false)
        }
    }
    
    func showError(_ errorCode: Int) {
        self.showError(errorCode: errorCode)
    }
}
