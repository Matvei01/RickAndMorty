//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

// MARK: - EpisodesViewController
final class EpisodesViewController: UITableViewController {

    // MARK: - Private Properties
    let cellID = "episodeCell"
    
    let episodes = Episode.getEpisodes()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = 70
        tableView.backgroundColor = .secondarySystemBackground
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Episodes"
    }
}

// MARK: - UITableViewDataSource
extension EpisodesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let episode = episodes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = episode.name
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EpisodesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        
        let episodeDetailsVC = EpisodeDetailsViewController()
        episodeDetailsVC.episode = episode
        
        navigationController?.pushViewController(episodeDetailsVC, animated: true)
    }
}
