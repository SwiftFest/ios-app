import Foundation

struct Session: Codable {
    
    let complexity: String?
    let description: String
    let id: String
    let outcome: String?
    let speakers: [String]
    let subtype: String
    let title: String
    
    enum CodingKeys: CodingKey {
        case complexity
        case description
        case id
        case outcome
        case speakers
        case subtype
        case title
    }
}
