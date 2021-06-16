//
//  SearchWorker.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/04/05.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

protocol SearchWorkerType: AnyObject {
    func schedule(type: SearchResultPresenterType, completion: @escaping (String) -> Void)
    func schedule(text: String, completion: @escaping (SearchResultPresenterType) -> Void)
}

class SearchWorker {
    private let interval: Double
    private let repeats: Bool

    private var timer: Timer?
    private var resultType: SearchResultPresenterType = .movie
    private var keyword: String = ""

    init(interval: Double, repeats: Bool) {
        self.interval = interval
        self.repeats = repeats
    }
}

// MARK: - Public: SearchWorkerType

extension SearchWorker: SearchWorkerType {
    func schedule(type: SearchResultPresenterType, completion: @escaping (String) -> Void) {
        guard resultType != type, !keyword.isEmpty else {
            return
        }
        resultType = type
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: { [weak self] _ in
            completion(self?.keyword ?? "")
        })
    }

    func schedule(text: String, completion: @escaping (SearchResultPresenterType) -> Void) {
        guard !text.isEmpty, keyword != text else {
            return
        }
        keyword = text
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: { [weak self] _ in
            completion(self?.resultType ?? .movie)
        })
    }
}
