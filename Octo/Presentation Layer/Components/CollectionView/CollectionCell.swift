//
//  CollectionCell.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

class CollectionCell: UICollectionViewCell, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {}
    
    func setupConstraints() {}
}
