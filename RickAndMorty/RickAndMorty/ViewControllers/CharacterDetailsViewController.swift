//
//  CharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Public Properties
    var character: Character!
    
    var cameFromEpisodeDetails: Bool = false
    
    // MARK: - UI Elements
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: character.image)
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
    
    // MARK: -  Action
    private lazy var episodesButtonTapped = UIAction { [unowned self] _ in
        let episodesVC = UINavigationController(rootViewController: EpisodesViewController())
        
        present(episodesVC, animated: true)
    }
    
    private lazy var backButtonTapped = UIAction { [unowned self] _ in
        navigationController?.popViewController(animated: true)
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
        
        setupNavigationBar()
    }
    
    func addSubviews() {
        setupSubviews(characterImageView, descriptionLabel)
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            primaryAction: backButtonTapped
        )
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
    }
}
