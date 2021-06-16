//
//  DetailAPISetting.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/03/28.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

enum DetailAPISetting: APISetting {
    case movieVideos(id: Int)
    case tvVideos(id: Int)
    case youbuteThumbnail(path: String)
    case youtubeMovie(path: String)

    var path: String {
        switch self {
        case let .movieVideos(id):
            return "/3/movie/\(id)/videos"
        case let .tvVideos(id):
            return "/3/tv/\(id)/videos"
        case let .youbuteThumbnail(path):
            return "/vi/\(path)/0.jpg"
        case let .youtubeMovie(path):
            return "/watch?v=\(path)"
        }
    }

    var host: String {
        switch self {
        case .movieVideos, .tvVideos:
            return "api.themoviedb.org"
        case .youbuteThumbnail:
            return "img.youtube.com"
        case .youtubeMovie:
            return "www.youtube.com"
        }
    }
}
