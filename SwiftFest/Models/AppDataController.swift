import Foundation

class AppDataController {

    static var shared = AppDataController()

    private init() {}

    lazy var agenda: Agenda = fetchData(fromFileNamed: "AgendaData")
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

    func fetchData<T: Decodable>(fromFileNamed name: String) -> T {
        let data = loadJSONDataFromFile(named: name)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode local file that should have been well-formed: \(error)")
        }
    }

    func loadJSONDataFromFile(named: String) -> Data {
        let path = Bundle.main.path(forResource: named, ofType: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }

}
