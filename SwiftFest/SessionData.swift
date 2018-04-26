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
    
    var parsedOutcomes: [String]? {
        guard let outcome = outcome else { return nil }
        return outcome.components(separatedBy: "\n")
    }
}

class SwiftFestSessions {
    
    //public var sessions: [Session] = []
    
    func loadSessionsFromStaticJSON() -> [Session] {
        
        var sessions: [Session] = []
        
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
        
        return sessions
    }
    
    func speakerSessionForSpeaker(_ speaker: Speaker) -> SpeakerSession {
        let sessions = loadSessionsFromStaticJSON()
        let sessionsResult = sessions.filter({ (session) -> Bool in
            guard let speakers = session.speakers else { return false }
            return speakers.contains(speaker.id)
        })
        if sessionsResult.count >= 1 {
            return SpeakerSession(speaker: speaker, sessions: sessionsResult)
        } else {
            return SpeakerSession(speaker: speaker, sessions: nil)
        }
    }
}
