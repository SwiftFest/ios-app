import Foundation

class AppDataController {

    static var shared = AppDataController()

    private init() {}

    lazy var agenda: Agenda = AppDataController.fetchData(fromFileNamed: "AgendaData")
    lazy var sessions: [Session] = AppDataController.fetchData(fromFileNamed: "SessionData")
    var speakers: [Speaker] = AppDataController.fetchData(fromFileNamed: "SpeakerData") {
        didSet {
            updateSpeakersById(with: speakers)
        }
    }
    lazy var teamMembers: [TeamMember] = AppDataController.fetchData(fromFileNamed: "TeamData")

    var speakersById: [Identifier<Speaker>: Speaker] = [:]

    func session(forSpeaker speakerId: Identifier<Speaker>) -> Session? {
        return sessions.first { session in
            session.speakers.contains(speakerId)
        }
    }

    /// Refreshes all the app data from the network.
    ///
    /// - Parameter completionHandler: Called when all refreshing is done.
    ///                                Assuming there were no errors, all the
    ///                                data in the app data controller will be
    ///                                updated.
    func refreshFromNetwork(completionHandler: @escaping (_ success: Bool) -> Void) {

        var agenda: Agenda?
        var sessions: [Session]?
        var speakers: [Speaker]?
        var teamMembers: [TeamMember]?

        let group = DispatchGroup()
        var success = true
        group.enter()
        APIClient.shared.fetchAgenda { agendaResult in
            agenda = agendaResult.value
            success = success && agendaResult.isSuccess
            group.leave()
        }

        group.enter()
        APIClient.shared.fetchSessions { sessionsResult in
            sessions = sessionsResult.value
            success = success && sessionsResult.isSuccess
            group.leave()
        }

        group.enter()
        APIClient.shared.fetchSpeakers { speakersResult in
            speakers = speakersResult.value
            success = success && speakersResult.isSuccess
            group.leave()
        }

        group.enter()
        APIClient.shared.fetchTeam { teamResult in
            teamMembers = teamResult.value
            success = success && teamResult.isSuccess
            group.leave()
        }

        group.notify(queue: .main) {
            guard success,
                let agenda = agenda,
                let sessions = sessions,
                let speakers = speakers,
                let teamMembers = teamMembers else {
                    completionHandler(false)
                    return
            }
            self.agenda = agenda
            self.sessions = sessions
            self.speakers = speakers
            self.teamMembers = teamMembers

            completionHandler(success)
        }
    }

}

private extension AppDataController {

    static func fetchData<T: Decodable>(fromFileNamed name: String) -> T {
        let data = loadJSONDataFromFile(named: name)

        do {
            return try JSONDecoder.default.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode local file that should have been well-formed: \(error)")
        }
    }

    static func loadJSONDataFromFile(named: String) -> Data {
        let path = Bundle.main.path(forResource: named, ofType: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }

    func updateSpeakersById(with speakers: [Speaker]) {
        self.speakersById = speakers.reduce(into: [:]) { (result, speaker) in
            result[speaker.id] = speaker
        }
    }

}
