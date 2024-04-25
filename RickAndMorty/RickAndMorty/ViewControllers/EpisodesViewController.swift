//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

// MARK: - EpisodesViewController
final class EpisodesViewController: UITableViewController {
    
    // MARK: - Public Properties
    var character: Character!
    
    // MARK: - Private Properties
    private let cellID = "episodeCell"
    
    private var episodes: [Episode] = []
    
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
        
        fetchEpisodes()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Episodes"
    }
    
    private func fetchEpisodes() {
        for episodeURL in character.episode {
            fetchEpisode(from: episodeURL)
        }
    }
    
    private func fetchEpisode(from url: URL?) {
        NetworkManager.shared.fetchData(Episode.self, from: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let episode):
                self.episodes.append(episode)
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
extension EpisodesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let episode = episodes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        content.text = episode.name
        
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
        
        self.navigationController?.pushViewController(episodeDetailsVC, animated: true)
    }
}
