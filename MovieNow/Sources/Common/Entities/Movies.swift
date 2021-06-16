import Foundation

struct Movies {
    let page: Int
    let results: [Movie]
    let totalPages: Int?
    let totalResults: Int?
}

// MARK: - Public: Codable

extension Movies: Codable {
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}
