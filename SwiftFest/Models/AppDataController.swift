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
        return fetchData(fromFileNamed: "SpeakerData")
    }

    func fetchTeamMembers() -> [TeamMember] {
        return fetchData(fromFileNamed: "TeamData")
    }
        
    func fetchSessions() -> [Session] {
        return fetchData(fromFileNamed: "SessionData")
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

}

private extension AppDataController {

    func fetchData<T>(fromFileNamed name: String) -> [T] where T: Decodable {
        let data = loadJSONDataFromFile(named: name)

        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print(error)
            return []
        }
    }

    func loadJSONDataFromFile(named: String) -> Data {
        let path = Bundle.main.path(forResource: named, ofType: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }

}
