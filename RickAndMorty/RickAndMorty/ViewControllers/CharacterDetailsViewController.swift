//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

// MARK: - CharacterDetailsViewController
final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Public Properties
    var character: Character!
    
    var cameFromEpisodeDetails: Bool = false
    
    // MARK: - UI Elements
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 120
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = character.description
        label.font = UIFont(name: "Apple Color Emoji", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: -  Action
    private lazy var episodesButtonTapped = UIAction { [weak self] _ in
        guard let self = self else { return }
        
        let episodesVC = EpisodesViewController()
        episodesVC.character = self.character
        
        let navEpisodesVC = UINavigationController(rootViewController: episodesVC)
        
        self.present(navEpisodesVC, animated: true)
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if cameFromEpisodeDetails {
            navigationItem.rightBarButtonItem = nil
        }
    }
}

// MARK: - Private methods
private extension CharacterDetailsViewController {
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        
        addSubviews()
        
        setConstraints()
        
        fetchImage()
        
        setupNavigationBar()
    }
    
    func addSubviews() {
        setupSubviews(characterImageView, descriptionLabel)
        
        characterImageView.addSubview(activityIndicator)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    func setupNavigationBar() {
        title = character.name
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Episodes",
            primaryAction: episodesButtonTapped
        )
    }
    
    func fetchImage() {
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageData):
                self.characterImageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }
}

// MARK: - Constraints
private extension CharacterDetailsViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 240),
            characterImageView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: characterImageView.centerYAnchor)
        ])
    }
}
