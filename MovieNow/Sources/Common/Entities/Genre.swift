import Foundation

enum Genre: Int, CaseIterable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case romance = 10749
    case scienceFiction = 878
    case tVMovie = 10770
    case thriller = 53
    case war = 10752
    case western = 37

    var list: String {
        switch self {
        case .action: return "action"
        case .adventure: return "adventure"
        case .animation: return "animation"
        case .comedy: return "comedy"
        case .crime: return "crime"
        case .documentary: return "documentary"
        case .drama: return "drama"
        case .family: return "family"
        case .fantasy: return "fantasy"
        case .history: return "history"
        case .horror: return "horror"
        case .music: return "music"
        case .romance: return "romance"
        case .scienceFiction: return "science fiction"
        case .tVMovie: return "TV Movie"
        case .thriller: return "thriller"
        case .war: return "war"
        case .western: return "western"
        }
    }
}
