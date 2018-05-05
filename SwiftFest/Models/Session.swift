import Foundation

struct Session: Codable {
    
    let complexity: String?
    let description: String?
    let id: String?
    let language: String?
    let outcome: String?
    let speakers: [String]?
    let subtype: String?
    let title: String?
    
    enum CodingKeys: CodingKey {
        case complexity
        case description
        case id
        case language
        case outcome
        case speakers
        case subtype
        case title
    }
    
    var parsedOutcomes: [String]? {
        guard let outcome = outcome else { return nil }
        return outcome.components(separatedBy: "\n")
    }
}
