import Foundation
import UIKit

struct Agenda: Decodable {
    
    let days: [Day]
    
    init(days: [Day]) {
        self.days = days
    }
    
    init(from decoder: Decoder) throws {
        var container = try! decoder.unkeyedContainer()
        let days = try? container.decode([Day].self)
        self.init(days: days ?? [])
    }
    
    struct Day: Decodable {
        
        // swiftlint:disable:next nesting
        enum CodingKeys: CodingKey {
            case date
            case timeslots
            case tracks
        }
        
        let date: DateComponents
        let timeslots: [Timeslot]
        let tracks: [Track]
        
        init(date: DateComponents, tracks: [Track], timeslots: [Timeslot]) {
            self.date = date
            self.tracks = tracks
            self.timeslots = timeslots
        }
        
        init(from decoder: Decoder) throws {
            // swiftlint:disable:next force_try
            let container = try! decoder.container(keyedBy: CodingKeys.self)
            // swiftlint:disable:next force_try
            let dateString = try! container.decode(String.self, forKey: .date)
            
            let formatter = ISO8601DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "EST")!
            let date = formatter.date(from: dateString)!
            
            let desiredComponents = Set<Calendar.Component>(arrayLiteral: .calendar, .hour, .minute, .day, .month, .year)
            let dateComponents = Calendar.current.dateComponents(desiredComponents, from: date)

            let tracks = try container.decode([Track].self, forKey: .tracks)
            self.init(date: dateComponents,
                      tracks: tracks,
                      // swiftlint:disable:next force_try
                      timeslots: try! container.decode([Timeslot].self, forKey: .timeslots))
        }
    }

    struct Track: Decodable {
        let title: String
        let color: String
    }
    
    struct Timeslot: Decodable {
        let startTime: DateComponents
        let endTime: DateComponents
        let sessionIds: [Identifier<Session>]
        
        // swiftlint:disable:next nesting
        enum CodingKeys: CodingKey {
            case startTime
            case endTime
            case sessionIds
        }
        
        init(startTime: DateComponents, endTime: DateComponents, sessionIds: [Identifier<Session>]) {
            self.startTime = startTime
            self.endTime = endTime
            self.sessionIds = sessionIds
        }
        
        init(from decoder: Decoder) throws {
            // swiftlint:disable:next force_try
            let container = try! decoder.container(keyedBy: CodingKeys.self)
            
            let formatter = ISO8601DateFormatter()
            formatter.timeZone = TimeZone(identifier: "EST")
            
            // swiftlint:disable:next force_try
            let startTimeString = try! container.decode(String.self, forKey: .startTime)
            // swiftlint:disable:next force_try
            let endTimeString = try! container.decode(String.self, forKey: .endTime)
            
            let startTimeDate = formatter.date(from: startTimeString)!
            let endTimeDate = formatter.date(from: endTimeString)!
            
            let desiredComponents = Set<Calendar.Component>(arrayLiteral: .calendar, .hour)
            let startTime = Calendar.current.dateComponents(desiredComponents, from: startTimeDate)
            let endTime = Calendar.current.dateComponents(desiredComponents, from: endTimeDate)
            
            // swiftlint:disable:next force_try
            let sessionIds = try! container.decode([Identifier<Session>].self, forKey: .sessionIds)
            
            self.init(startTime: startTime, endTime: endTime, sessionIds: sessionIds)
        }
    }
}

extension Agenda.Track {

    var uiColor: UIColor {
        return UIColor(hexString: color)
    }

}
