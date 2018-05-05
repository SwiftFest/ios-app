import Nimble
import Quick
@testable import SwiftFest

class JSONDeserializationSpec: QuickSpec {
    override func spec() {
        
        describe("JSON deserialization of the models") {
            it("deserializes the sessions") {
                let sessions = AppDataController().loadSessionsFromStaticJSON()
                expect(sessions).to(haveCount(36))
            }
            
            it("deserializes the speakers") {
                let speakers = AppDataController().loadSpeakersFromStaticJSON()
                expect(speakers).to(haveCount(34))
            }
            
            it("deserializes the agenda") {
                let agenda = AppDataController().loadScheduleFromStaticJSON()
                expect(agenda.days).to(haveCount(2))
                expect(agenda.days.first?.date).to(equal(DateComponents(year: 2018, month: 06, day: 18)))
                
                let firstTimeslot = agenda.days.first?.timeslots.first
                let tenAM = DateComponents(hour: 10)
                let elevenAM = DateComponents(hour: 11)
                
                expect(firstTimeslot?.startTime).to(equal(tenAM))
                expect(firstTimeslot?.endTime).to(equal(elevenAM))
                expect(firstTimeslot?.sessionIds).to(equal(["001"]))
            }
        }
        
    }
}
