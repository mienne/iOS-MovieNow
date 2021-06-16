//
//  SearchViewModel.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/04/16.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

final class SearchViewModel {
    private let worker: SearchWorkerType
    private var useCase: SearchUseCase

    private var isLoading: Bool = false
    private var currentPage: Int = 1

    var onSuccess: ((SearchResultPresenter<SearchResultPresenterType>?) -> Void) = { _ in }
    var onFailure: ((Error) -> Void) = { _ in }

    init(useCase: SearchUseCase, worker: SearchWorkerType) {
        self.useCase = useCase
        self.worker = worker
    }

    func update(to type: SearchResultPresenterType) {
        worker.schedule(type: type) { [weak self] text in
            let request = SearchNextRequestPresenter(text: text, type: type, movies: [])
            self?.find(next: request)
        }
    }

    func update(to text: String) {
        worker.schedule(text: text) { [weak self] type in
            let request = SearchNextRequestPresenter(text: text, type: type, movies: [])
            self?.find(next: request)
        }
    }

    func update(next request: SearchNextRequestPresenter) {
        find(next: request)
    }
}

// MARK: - Private

private extension SearchViewModel {
    func find(next request: SearchNextRequestPresenter) {
        if isLoading { return }
        isLoading = true
        currentPage = request.hasMovies ? currentPage + 1 : 1
        useCase.find(page: currentPage, request: request) { [weak self] result in
            switch result {
            case let .success(result):
                self?.isLoading = false
                self?.onSuccess(result)
            case let .failure(error):
                self?.isLoading = false
                self?.onFailure(error)
            }
        }
    }
}
