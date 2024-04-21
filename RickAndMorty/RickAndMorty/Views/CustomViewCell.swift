//
//  CustomViewCell.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import UIKit

final class CustomViewCell: UITableViewCell {

    // MARK: - Override Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
