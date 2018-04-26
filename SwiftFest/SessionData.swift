import Foundation

struct SessionResults: Codable {
    let sessions: [Session]
    
    enum CodingKeys: String, CodingKey {
        case sessions = "results"
    }
}

struct Session: Codable {
    
    let complexity: String?
    let description: String?
    let id: Int?
    let language: String?
    let outcome: String?
    let speakers: [Int]?
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
    
}

class SwiftFestSessions {
    
    public var sessions: [Session] = []
    
    func loadSessionsFromStaticJSON() {
        
        var sessionData: Data?
        
        if let path = Bundle.main.path(forResource: "SessionData", ofType: "json") {
            sessionData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        
        let decoder = JSONDecoder()
        let decodedSessions = try? decoder.decode(SessionResults.self, from: sessionData!)
        
        if let sessionResults = decodedSessions?.sessions {
            for session in sessionResults {
                sessions.append(session)
            }
        }
    }
    
    func sessionsForSpeakerId(_ id: Int) -> [Session] {
        return sessions.filter({ (session) -> Bool in
            guard let speakers = session.speakers else { return false }
            return speakers.contains(id)
        })
    }
}
