import Foundation

class AppDataController {
    
    func fetchAgenda() -> Agenda {
        let agendaData = loadJSONDataFromFile(named: "AgendaData")
        
        do {
            let days = try JSONDecoder().decode([Agenda.Day].self, from: agendaData)
            return Agenda(days: days)
        } catch {
            print(error)
            return Agenda(days: [])
        }
    }
    
    func fetchSpeakers() -> [Speaker] {
        let speakersData = loadJSONDataFromFile(named: "SpeakerData")
        
        do {
            return try JSONDecoder().decode([Speaker].self, from: speakersData)
        } catch {
            print(error)
            return []
        }
    }
        
    func fetchSessions() -> [Session] {
        let sessionData = loadJSONDataFromFile(named: "SessionData")
        
        do {
            return try JSONDecoder().decode([Session].self, from: sessionData)
        } catch {
            print(error)
            return []
        }
    }
    
    func fetchSpeakerThumbnailUrls() -> [String: String] {
        var speakerThumbnailUrls = [String: String]()
        for speaker in fetchSpeakers() {
            if let speakerSession = speakerSessionForSpeaker(speaker) {
                speakerThumbnailUrls[speakerSession.session.id] = speaker.thumbnailUrl
            }
        }

        return speakerThumbnailUrls
    }
    
    func session(for id: String) -> Session {
        let sessions = fetchSessions()
        return sessions.first {
            $0.id == id
        }!
    }
    
    func session(for speaker: Speaker) -> Session? {
        let sessions = fetchSessions()
        let filteredSessions = sessions.filter { session in
            session.speakers.contains(speaker.id)
        }
        
        return filteredSessions.first
    }
    
    func speakerSessionForSpeaker(_ speaker: Speaker) -> SpeakerSession? {
        guard let session = session(for: speaker) else {
            return nil
        }
        
        return SpeakerSession(speaker: speaker, session: session)
    }
    
    private func loadJSONDataFromFile(named: String) -> Data {
        let path = Bundle.main.path(forResource: named, ofType: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }
}
