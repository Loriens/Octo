//
//  PhotoListDataSource.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

final class PhotoListDataSource: UICollectionViewDiffableDataSource<PhotoListModule.Section, PhotoListModule.Item> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            let cell = collectionView.dequeue(PhotoListCell.self, for: indexPath)
            cell.update(item: item)
            return cell
        }
        collectionView.register(PhotoListCell.self, forCellWithReuseIdentifier: PhotoListCell.reuseIdentifier)
    }
}
