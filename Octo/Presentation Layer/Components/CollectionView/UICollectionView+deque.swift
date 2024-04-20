//
//  UICollectionView+deque.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell & Reusable>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Could not dequeue cell: \(T.reuseIdentifier)")
        }
        return cell
    }
}
