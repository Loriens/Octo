//
//  PhotoListViewModel.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import Combine
import Foundation
import UIKit

final class PhotoListViewModel {
    typealias Snapshot = NSDiffableDataSourceSnapshot<PhotoListModule.Section, PhotoListModule.Item>
    
    @Published var snapshot: Snapshot?
    @Published var error: PhotoListModule.Error?
    var openPhotoDetail: AnyPublisher<PhotoDetailModule.Item, Never> {
        openPhotoDetailSubject.eraseToAnyPublisher()
    }

    private let networkService: NetworkService
    private var items: [PhotoListModule.Item] = []
    private let openPhotoDetailSubject = PassthroughSubject<PhotoDetailModule.Item, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var isLoading = false
    private var nextListUrl: URL?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadData() {
        isLoading = true
    
        cancellables.removeAll()
        
        let request = PhotoListRequestFactory.list.makeRequest()
        networkService
            .getPublisher(request: request)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.error = makeListError(networkError: error)
                }
                isLoading = false
            } receiveValue: { [unowned self] (value: PhotoListDTO) in
                snapshot = makeSnapshot(dto: value)
                nextListUrl = URL(string: value.next_page ?? "")
                isLoading = false
            }
            .store(in: &cancellables)
    }

    func collectionViewDidSelectItem(indexPath: IndexPath) {
        guard items.indices.contains(indexPath.row) else { return }
        
        let item = items[indexPath.row]
        let detailItem = PhotoDetailModule.Item(id: item.id, title: item.title, imageUrl: item.imageUrl, author: item.author)

        openPhotoDetailSubject.send(detailItem)
    }
    
    func collectionViewWillDisplayCell(indexPath: IndexPath) {
        guard
            indexPath.row > items.count - 3,
            let nextListUrl,
            !isLoading
        else { return }

        loadMoreData(nextListUrl: nextListUrl)
    }
    
    private func loadMoreData(nextListUrl: URL) {
        isLoading = true
        
        let request = PhotoListRequestFactory.nextList(url: nextListUrl).makeRequest()
        networkService
            .getPublisher(request: request)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.error = makeListError(networkError: error)
                }
                isLoading = false
            } receiveValue: { [unowned self] (value: PhotoListDTO) in
                snapshot = makeMoreSnapshot(dto: value)
                self.nextListUrl = URL(string: value.next_page ?? "")
                isLoading = false
            }
            .store(in: &cancellables)
    }
    
    private func makeSnapshot(dto: PhotoListDTO) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        items = dto.photos?.compactMap(makeItem) ?? []
        snapshot.appendItems(items)
        return snapshot
    }
    
    private func makeMoreSnapshot(dto: PhotoListDTO) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        items.append(contentsOf: dto.photos?.compactMap(makeItem) ?? [])
        snapshot.appendItems(items)
        return snapshot
    }
    
    private func makeItem(photo: PhotoItemDTO?) -> PhotoListModule.Item? {
        guard
            let photo = photo,
            let previewImageUrl = URL(string: photo.src.medium ?? ""),
            let imageUrl = URL(string: photo.src.original ?? "")
        else { return nil }

        let item = PhotoListModule.Item(
            id: photo.id,
            title: photo.alt,
            previewImageUrl: previewImageUrl,
            imageUrl: imageUrl,
            author: photo.photographer ?? ""
        )
        return item
    }
    
    private func makeListError(networkError: NetworkError) -> PhotoListModule.Error {
        switch networkError {
        case .invalidAuthorization:
            return .invalidAuthorization
        default:
            return .unknown(error)
        }
    }
}
