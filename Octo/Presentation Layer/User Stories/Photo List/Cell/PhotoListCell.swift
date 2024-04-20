//
//  PhotoListCell.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit
import Kingfisher

final class PhotoListCell: CollectionCell {
    private let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = PTRootUI.bold.dynamicallyScalingFont(size: 18)
        label.textColor = AppStyle.Text.primary
        return label
    }()
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let authorLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = PTRootUI.regular.dynamicallyScalingFont(size: 16)
        label.textColor = AppStyle.Text.secondary
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        authorLabel.text = ""
        imageView.image = nil
        imageView.kf.cancelDownloadTask()
    }

    override func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(authorLabel)

        isAccessibilityElement = true
        accessibilityTraits = .button

        backgroundColor = .clear

        contentView.backgroundColor = .clear
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: authorLabel.topAnchor),
            
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    func update(item: PhotoListModule.Item) {
        titleLabel.text = item.title
        imageView.kf.setImage(with: .network(item.previewImageUrl))
        authorLabel.text = "Author: " + item.author
    }
}
