//
//  EpisodeDetailsViewController.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

// MARK: - EpisodeDetailsViewController
final class EpisodeDetailsViewController: UIViewController {
    
    // MARK: - Public Properties
    var episode: Episode!
    
    // MARK: - Private Properties
    private let cellID = "episodeDetailsCell"
    
    private var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted { $0.id < $1.id }
            }
        }
    }
    
    // MARK: - UI Elements
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = episode.description
        label.font = UIFont(name: "Kefa", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var charactersLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomViewCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - UITableViewDataSource
extension EpisodeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = cell as? CustomViewCell else { return UITableViewCell() }
        
        let characterURL = episode.characters[indexPath.row]
        
        NetworkManager.shared.fetchCharacter(from: characterURL) { result in
            switch result {
            case .success(let character):
                cell.configure(character: character)
            case .failure(let error):
                print(error)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EpisodeDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        
        let characterDetailsVC = CharacterDetailsViewController()
        characterDetailsVC.character = character
        characterDetailsVC.cameFromEpisodeDetails = true
        
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}

// MARK: - Private methods
private extension EpisodeDetailsViewController {
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        
        addSubviews()
        
        setupNavigationBar()
        
        setConstraints()
        
        setCharacters()
    }
    
    func addSubviews() {
        setupSubviews(
            descriptionLabel,
            charactersLabel,
            charactersTableView
        )
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationBar() {
        title = episode.episode
    }
    
    func setCharacters() {
        for characterURL in episode.characters {
            NetworkManager.shared.fetchCharacter(from: characterURL) { [weak self] result in
                switch result {
                case .success(let character):
                    self?.characters.append(character)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: - Constraints
private extension EpisodeDetailsViewController {
    func setConstraints() {
        setConstraintsForDescriptionLabel()
        setConstraintsForCharactersLabel()
        setConstraintsForCharactersTableView()
    }
    
    func setConstraintsForDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setConstraintsForCharactersLabel() {
        NSLayoutConstraint.activate([
            charactersLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 60),
            charactersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setConstraintsForCharactersTableView() {
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: charactersLabel.bottomAnchor, constant: 16),
            charactersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
