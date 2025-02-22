//
//  CharacterListViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 30/06/23.
//

import Foundation
import UIKit
import MaterialComponents.MaterialButtons
import AVFoundation

class CharacterListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Atributes
    private var characters: [Character] = []
    private lazy var characterViewModel: CharacterViewModel = CharacterViewModel(characterDelegate: self)
    private var fab: MDCFloatingButton!
    private let refreshControl = UIRefreshControl()
    private var offset = 0
    private var player: AVAudioPlayer?
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        self.configureNavigationBarAndRightBarButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBarAndSearchBar()
        self.configureFloatingButton()
        self.configureTableView()
        self.configureDelegate()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        self.characterTableView.reloadData()
        self.activityIndicatorView.configureAndHide()
        self.getCharacters()
    }
    
    // MARK: - Methods
    private func configureFloatingButton() {
        let widwonWidth = UIScreen.main.bounds.width - 50 - 25
        let windowHeight = UIScreen.main.bounds.height - 50 - 25
        
        self.fab = MDCFloatingButton(frame: CGRect(x: widwonWidth, y: windowHeight, width: 50, height: 50))
        self.fab.backgroundColor = .blue
        self.fab.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        self.fab.addTarget(self, action: #selector(showSearchView), for: .touchUpInside)
        self.fab.accessibilityIdentifier = "fabSearchBar"
        
        self.view.addSubview(self.fab)
    }
    
    private func configureTableView() {
        self.characterTableView.accessibilityIdentifier = "characterTableView"
        self.characterTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.characterTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        self.characterTableView.isScrollEnabled = true
        self.characterTableView.remembersLastFocusedIndexPath = true
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
        self.characterTableView.refreshControl = self.refreshControl
        self.refreshControl.endRefreshing()
    }
    
    private func configureDelegate() {
        self.characterTableView.dataSource = self
        self.characterTableView.delegate = self
        
        self.searchBar.delegate = self
    }
    
    private func configureNavBarAndSearchBar() {
        let searchBarPosY: CGFloat = switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                75
            
            case .phone:
                95
            
            default:
                85
        }
        
        self.searchBar.accessibilityIdentifier = "characterByNameSearchBar"
        self.searchBar.frame.origin.y = searchBarPosY
        self.searchBar.isHidden = true
        self.searchBar.placeholder = String(localized: "search_character_by_name")
        self.searchBar.showsLargeContentViewer = true
    }
    
    private func getCharacters() {
        self.activityIndicatorView.show()
        self.characterViewModel.getCharacters(offset: offset)
    }
    
    private func getCharactersByName(_ name: String) {
        self.activityIndicatorView.show()
        self.characterViewModel.getCharactersByName(name)
    }
    
    private func viewDetailsOfCharacter(_ character: Character) {
        let characterViewController = CharacterViewController.intanciate(character)
        characterViewController.modalPresentationStyle = .automatic
        
        self.changeViewControllerWithPushViewController(characterViewController)
    }
    
    private func playSound() {
        let url = Bundle.main.url(forResource: "swipe_sound", withExtension: "mp3")!
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc private func refreshTableView() {
        self.offset = 0
        self.playSound()
        self.getCharacters()
        self.refreshControl.endRefreshing()
    }
    
    @objc private func paginateTableView() {
        self.offset += 20
        self.getCharacters()
        self.refreshControl.endRefreshing()
    }
    
    @objc func showSearchView() {
        if self.searchBar.isHidden {
            self.searchBar.isHidden = false
        } else {
            self.searchBar.isHidden = true
        }
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("error creating CharacterTableViewCell")
        }

        let character = self.characters[indexPath.row]
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
        if let lastCellRowIndex = tableView.indexPathsForVisibleRows?.last?.row {
            if self.characters.count - 1 >= lastCellRowIndex + 1 {
                self.fab?.isHidden = false
            } else {
                self.fab?.isHidden = true
            }
        }
        
        if indexPath.row == self.characters.count-1, self.characters.count >= 20 {
            self.paginateTableView()
        }
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 205
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.characterTableView.deselectRow(at: indexPath, animated: true)
        
        let character: Character = self.characters[indexPath.row]
        self.viewDetailsOfCharacter(character)
    }
}

// MARK: - UISearchBarDelegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.hideKeyboard()
        let nameCharacter = searchBar.text?.replacingOccurrences(of: " ", with: "%20") ?? ""
        self.getCharactersByName(nameCharacter)
    }
}

// MARK: - CharacterDelegaate
extension CharacterListViewController: CharacterDelegate {
    func populateTableView(characters: [Character]) {
        DispatchQueue.main.async {
            self.activityIndicatorView.hide()
            
            self.characters = characters
            self.characterTableView.reloadData()
            
            if self.offset != 0 {
                let targetRonIdexPath = IndexPath(row: self.characters.count-5, section: 0)
                self.characterTableView.scrollToRow(at: targetRonIdexPath, at: .middle, animated: false)
            }
        }
    }
    
    func replaceAll(characters: [Character]) {
        DispatchQueue.main.async {
            self.activityIndicatorView.hide()
            
            if characters.isEmpty {
                self.showAlert(title: "", message: String(localized: "error_character_not_found"))
            } else {
                self.characters.removeAll()
                self.characters = characters
                self.characterTableView.reloadData()
                self.searchBar.isHidden = true
                
                if characters.count > 10 {
                    let targetRonIdexPath = IndexPath(row: 0, section: 0)
                    self.characterTableView.scrollToRow(at: targetRonIdexPath, at: .top, animated: false)
                }
            }
        }
    }
    
    func showError(_ errorCode: Int) {
        self.activityIndicatorView.hide()
        self.showErrorMessage(errorCode: errorCode)
    }
    
    func noInternet() {
        DispatchQueue.main.async {
            self.activityIndicatorView.hide()
            self.showAlert(title: "", message: String(localized: "no_internet"))
        }
    }
}
