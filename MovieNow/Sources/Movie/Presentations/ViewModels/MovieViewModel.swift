//
//  MovieViewModel.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/04/16.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct MovieViewModel {
    private let useCase: MovieUseCase

    var onSuccess: (([MoviesPresenter<MoviesPresenterType>]) -> Void) = { _ in }

    init(_ useCase: MovieUseCase) {
        self.useCase = useCase
    }

    func fetch() {
        useCase.loadDatas { presenter in
            self.onSuccess(presenter)
        }
    }
}
