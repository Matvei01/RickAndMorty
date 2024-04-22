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
    func configure(character: Character) {
        characterImageView.image = UIImage(named: character.image)
        nameLabel.text = character.name
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
