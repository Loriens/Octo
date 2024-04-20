//
//  PhotoListView.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Combine
import UIKit

final class PhotoListView: UIViewController {
    private let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var router: PhotoListRouting?
    private let viewModel: PhotoListViewModel
    private var dataSource: PhotoListDataSource?
    private var cancellables = Set<AnyCancellable>()
    
    
    init(viewModel: PhotoListViewModel) {
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

        loadData()
    }
    
    private func setupComponents() {
        view.addSubview(collectionView)

        navigationItem.title = AppLocalization.PhotoList.title.localized
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        dataSource = PhotoListDataSource(collectionView: collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        view.backgroundColor = AppStyle.Background.basic
        collectionView.backgroundColor = AppStyle.Background.basic
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

    private func setupActions() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    private func setupViewModel() {
        [
            viewModel.$snapshot.sink { [unowned self] snapshot in
                guard let snapshot else { return }
                collectionView.refreshControl?.endRefreshing()
                dataSource?.apply(snapshot, animatingDifferences: true)
            },
            viewModel.$error.sink { [unowned self] error in
                guard let error else { return }
                collectionView.refreshControl?.endRefreshing()
                router?.presentAlert(error: error)
            },
            viewModel.openPhotoDetail.sink { [unowned self] item in
                router?.routeToPhotoDetail(item: item)
            }
        ].forEach { $0.store(in: &cancellables) }
    }
    
    // MARK: - Actions
    
    @objc
    func loadData() {
        viewModel.loadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionViewDidSelectItem(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.collectionViewWillDisplayCell(indexPath: indexPath)
    }
}
