import Foundation

struct Session: Codable {
    
    let complexity: String?
    let description: String
    let id: Identifier<Session>
    let outcome: String?
    let speakers: [Identifier<Speaker>]
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
