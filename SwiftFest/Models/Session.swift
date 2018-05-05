import Foundation

struct Session: Codable {
    
    let complexity: String?
    let description: String?
    let id: Int?
    let language: String?
    let outcome: String?
    let speakers: [Int]?
    let subtype: String?
    let title: String?
    let date: DateComponents?
    
    enum CodingKeys: CodingKey {
        case complexity
        case description
        case id
        case language
        case outcome
        case speakers
        case subtype
        case title
        case date
    }
    
    var parsedOutcomes: [String]? {
        guard let outcome = outcome else { return nil }
        return outcome.components(separatedBy: "\n")
    }
}
