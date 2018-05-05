import Foundation

struct Agenda {
    
    struct Day: Decodable {
        
        // swiftlint:disable:next nesting
        enum CodingKeys: CodingKey {
            case date
            case timeslots
        }
        
        let date: DateComponents
        let timeslots: [Timeslot]
        
        init(from decoder: Decoder) throws {
            // swiftlint:disable:next force_try
            let container = try! decoder.container(keyedBy: CodingKeys.self)
            // swiftlint:disable:next force_try
            let dateString = try! container.decode(String.self, forKey: .date)
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            
            let date = formatter.date(from: dateString)!
            let desiredComponents = Set<Calendar.Component>(arrayLiteral: .day, .month, .year)
            self.date = Calendar.current.dateComponents(desiredComponents, from: date)
            // swiftlint:disable:next force_try
            self.timeslots = try! container.decode([Timeslot].self, forKey: .timeslots)
        }
    }
    
    struct Timeslot: Decodable {
        let startTime: DateComponents
        let endTime: DateComponents
        let sessionIds: [String]
        
        // swiftlint:disable:next nesting
        enum CodingKeys: CodingKey {
            case startTime
            case endTime
            case sessionIds
        }
        
        init(startTime: DateComponents, endTime: DateComponents, sessionIds: [String]) {
            self.startTime = startTime
            self.endTime = endTime
            self.sessionIds = sessionIds
        }

        init(from decoder: Decoder) throws {
            // swiftlint:disable:next force_try
            let container = try! decoder.container(keyedBy: CodingKeys.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"

            // swiftlint:disable:next force_try
            let startTimeString = try! container.decode(String.self, forKey: .startTime)
            // swiftlint:disable:next force_try
            let endTimeString = try! container.decode(String.self, forKey: .endTime)
            
            let startTimeDate = formatter.date(from: startTimeString)!
            let endTimeDate = formatter.date(from: endTimeString)!
            
            let desiredComponents = Set<Calendar.Component>(arrayLiteral: .hour)
            let startTime = Calendar.current.dateComponents(desiredComponents, from: startTimeDate)
            let endTime = Calendar.current.dateComponents(desiredComponents, from: endTimeDate)
            // swiftlint:disable:next force_try
            let sessionIds = try! container.decode([String].self, forKey: .sessionIds)
            self.init(startTime: startTime, endTime: endTime, sessionIds: sessionIds)
        }
    }
    
    let days: [Day]
}

class AppDataController {
    
    func loadScheduleFromStaticJSON() -> Agenda {
        let agendaData = loadJSONDataFromFile(named: "AgendaData")
        
        do {
            let days = try JSONDecoder().decode([Agenda.Day].self, from: agendaData)
            return Agenda(days: days)
        } catch {
            print(error)
            return Agenda(days: [])
        }
    }
    
    func loadSpeakersFromStaticJSON() -> [Speaker] {
        let speakersData = loadJSONDataFromFile(named: "SpeakerData")
        
        do {
            return try JSONDecoder().decode([Speaker].self, from: speakersData)
        } catch {
            print(error)
            return []
        }
    }
        
    func loadSessionsFromStaticJSON() -> [Session] {
        
        let sessionData = loadJSONDataFromFile(named: "SessionData")
        
        do {
            return try JSONDecoder().decode([Session].self, from: sessionData)
        } catch {
            print(error)
            return []
        }
    }
    
    var allSpeakerSessions: [SpeakerSession] {
        let speakers = loadSpeakersFromStaticJSON()
        return speakers.map { speakerSessionForSpeaker($0) }
    }
    
    func speakerSessionForSpeaker(_ speaker: Speaker) -> SpeakerSession {
        
        let sessions = loadSessionsFromStaticJSON()
        
        let filteredSessions = sessions.filter { session in
            guard let speakers = session.speakers else { return false }
            return speakers.contains(speaker.id)
        }
        
        return SpeakerSession(speaker: speaker, session: filteredSessions.first)
    }
    
    private func loadJSONDataFromFile(named: String) -> Data {
        let path = Bundle.main.path(forResource: named, ofType: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }
}
