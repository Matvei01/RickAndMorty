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
    let characters = Character.getCharacters()
    
    let cellID = "characterCell"
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 70
        tableView.backgroundColor = .secondarySystemBackground
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", primaryAction: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Prev", primaryAction: nil)
    }
}

// MARK: - UITableViewDataSource
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        guard let cell = cell as? CustomViewCell else  { return UITableViewCell() }
        
        let character = characters[indexPath.row]
        
        cell.configure(character: character)
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsVC = CharacterDetailsViewController()
        let character = characters[indexPath.row]
        characterDetailsVC.character = character
        
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}


