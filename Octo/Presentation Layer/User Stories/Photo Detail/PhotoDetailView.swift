//
//  PhotoDetailView.swift
//  Octo
//
//  Created by Vladislav Markov on 22.04.2024.
//

import Combine
import Foundation
import Kingfisher
import UIKit

final class PhotoDetailView: UIViewController {
    private let imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var router: PhotoDetailRouting?
    private let viewModel: PhotoDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    init(viewModel: PhotoDetailViewModel) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupConstraints()
        setupActions()
        setupViewModel()

        viewModel.loadData()
    }
    
    private func setupComponents() {
        view.addSubview(imageView)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = AppStyle.Background.basic
    }

    private func setupConstraints() {
        let inset: CGFloat = 50
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -inset),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -inset)
        ])
    }

    private func setupActions() {}

    private func setupViewModel() {
        [
            viewModel.$title.sink { [unowned self] title in
                guard let title else { return }
                navigationItem.title = title
            },
            viewModel.$imageUrl.sink { [unowned self] imageUrl in
                guard let imageUrl else { return }
                imageView.kf.setImage(with: .network(imageUrl))
            }
        ].forEach { $0.store(in: &cancellables) }
    }
}
