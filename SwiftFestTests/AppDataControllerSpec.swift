import Nimble
import Quick
@testable import SwiftFest

class AppDataControllerSpec: QuickSpec {
    override func spec() {
        let subject = AppDataController()
        describe("AppDataController") {
            
            it("can get a session given a session id") {
                let sessionOne = subject.session(for: "001")
                let sessionTwo = subject.session(for: "004")
                
                expect(sessionOne.title).to(equal("Keynote: Accidentally Famous"))
                expect(sessionTwo.title).to(equal("Patterns & Methodologies for Test Suite Design"))
            }
            
            describe("JSON deserialization of the models") {
                it("deserializes the sessions") {
                    let sessions = subject.fetchSessions()
                    expect(sessions).to(haveCount(36))
                }
                
                it("deserializes the speakers") {
                    let speakers = subject.fetchSpeakers()
                    expect(speakers).to(haveCount(34))
                }
                
                it("deserializes the agenda") {
                    let agenda = subject.fetchAgenda()
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
}
