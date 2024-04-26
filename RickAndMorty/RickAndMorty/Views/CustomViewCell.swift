//
//  CustomViewCell.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

// MARK: - CustomViewCell
final class CustomViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Override Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(character: Character?) {
        guard let character = character else {
            print("Character is nil")
            return
        }
        
        nameLabel.text = character.name
        
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageData):
                self.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }
}

// MARK: - Private methods
private extension CustomViewCell {
    func setupView() {
        contentView.backgroundColor = .secondarySystemBackground
        
        addSubviews()
        
        setConstraints()
    }
    
    func addSubviews() {
        setupSubviews(characterImageView, nameLabel)
    }
    
    func setupSubviews(_ subviews: UIView... ) {
        for subview in subviews {
            contentView.addSubview(subview)
        }
    }
}

// MARK: - Constraints
private extension CustomViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -7),
            characterImageView.widthAnchor.constraint(equalToConstant: 50),
            characterImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
