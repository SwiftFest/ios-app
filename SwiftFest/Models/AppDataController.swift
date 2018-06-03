import Foundation

class AppDataController {

    static var shared = AppDataController()

    private init() {}

    lazy var agenda: Agenda = {
        let agendaData = loadJSONDataFromFile(named: "AgendaData")

        do {
            let days = try JSONDecoder().decode([Agenda.Day].self, from: agendaData)
            return Agenda(days: days)
        } catch {
            print(error)
            return Agenda(days: [])
        }
    }()
    
    lazy var speakers: [Speaker] = fetchData(fromFileNamed: "SpeakerData")
    lazy var teamMembers: [TeamMember] = fetchData(fromFileNamed: "TeamData")
    lazy var sessions: [Session] = fetchData(fromFileNamed: "SessionData")

    lazy var speakersById: [Identifier<Speaker>: Speaker] = {
        var speakersById = [Identifier<Speaker>: Speaker]()
        for speaker in speakers {
            speakersById[speaker.id] = speaker
        }

        return speakersById
    }()

    func session(forSpeaker speakerId: Identifier<Speaker>) -> Session? {
        return sessions.first { session in
            session.speakers.contains(speakerId)
        }
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
