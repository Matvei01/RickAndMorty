//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

// MARK: - CharactersViewController
final class CharactersViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var rickAndMorty: RickAndMorty?
    
    private var filteredCharacter: [Character] = []
    
    private let cellID = "characterCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: -  Action
    private lazy var updateData = UIAction { [unowned self] action in
        guard let sender = action.sender as? UIBarButtonItem else { return }
        
        switch sender.tag {
        case 0:
            fetchData(from: rickAndMorty?.info.prev)
        default:
            fetchData(from: rickAndMorty?.info.next)
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 70
        tableView.backgroundColor = .secondarySystemBackground
        
        fetchData(from: RickAndMortyAPI.baseURL.url)
        
        setupNavigationBar()
        
        setupSearchController()
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let prevButton = UIBarButtonItem(title: "Prev", primaryAction: updateData)
        prevButton.tag = 0
        
        let nextButton = UIBarButtonItem(title: "Next", primaryAction: updateData)
        nextButton.tag = 1
        
        navigationItem.leftBarButtonItem = prevButton
        navigationItem.rightBarButtonItem = nextButton
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchData(from url: URL?) {
        NetworkManager.shared.fetchData(RickAndMorty.self, from: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty = rickAndMorty
                self.tableView.reloadData()
            case .failure(let error):
                print("Error fetching rickAndMorty: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCharacter.count
        }
        return rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        guard let cell = cell as? CustomViewCell else  { return UITableViewCell() }
        
        var character: Character?
        
        if isFiltering {
            character = filteredCharacter[indexPath.row]
        } else {
            character = rickAndMorty?.results[indexPath.row]
        }
        
        cell.configure(character: character)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsVC = CharacterDetailsViewController()
        
        var character: Character?
        
        if isFiltering {
            character = filteredCharacter[indexPath.row]
        } else {
            character = rickAndMorty?.results[indexPath.row]
        }
        
        characterDetailsVC.character = character
        
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacter = rickAndMorty?.results.filter({ character in
            character.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        
        tableView.reloadData()
    }
}


