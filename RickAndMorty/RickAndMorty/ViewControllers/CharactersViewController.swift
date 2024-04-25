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
    private let cellID = "characterCell"
    
    private var rickAndMorty: RickAndMorty?
    
    // MARK: -  Action
    private lazy var updateData = UIAction { [unowned self] action in
        guard let sender = action.sender as? UIBarButtonItem else { return }
        
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 70
        tableView.backgroundColor = .secondarySystemBackground
        
        fetchData(from: RickAndMortyAPI.baseURL.url)
        
        setupNavigationBar()
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
    
    private func fetchData(from url: URL?) {
        NetworkManager.shared.fetchData(RickAndMorty.self, from: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty = rickAndMorty
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        guard let cell = cell as? CustomViewCell else  { return UITableViewCell() }
        
        let character = rickAndMorty?.results[indexPath.row]
        
        cell.configure(character: character)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsVC = CharacterDetailsViewController()
        let character = rickAndMorty?.results[indexPath.row]
        characterDetailsVC.character = character
        
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}


