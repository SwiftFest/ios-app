import Foundation
import UIKit

struct Agenda: Decodable {
    
    let days: [Day]
    
    init(days: [Day]) {
        self.days = days
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var days: [Day] = []
        while !container.isAtEnd {
            days.append(try container.decode(Day.self))
        }
        self.init(days: days)
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
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let date = try container.decode(Date.self, forKey: .date)
            
            let desiredComponents = Set<Calendar.Component>(arrayLiteral: .calendar, .hour, .minute, .day, .month, .year)
            let dateComponents = Calendar.current.dateComponents(desiredComponents, from: date)

            let tracks = try container.decode([Track].self, forKey: .tracks)
            self.init(date: dateComponents,
                      tracks: tracks,
                      timeslots: try container.decode([Timeslot].self, forKey: .timeslots))
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
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let startTime = try container.decode(Date.self, forKey: .startTime)
            let endTime = try container.decode(Date.self, forKey: .endTime)
            
            let desiredComponents = Set<Calendar.Component>(arrayLiteral: .calendar, .hour, .minute)
            let startComponents = Calendar.current.dateComponents(desiredComponents, from: startTime)
            let endComponents = Calendar.current.dateComponents(desiredComponents, from: endTime)
            
            let sessionIds = try container.decode([Identifier<Session>].self, forKey: .sessionIds)
            
            self.init(startTime: startComponents, endTime: endComponents, sessionIds: sessionIds)
        }
    }
}

extension Agenda.Track {

    var uiColor: UIColor {
        return UIColor(hexString: color)
    }

}
