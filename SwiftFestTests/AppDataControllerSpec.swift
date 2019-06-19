import Nimble
import Quick
@testable import SwiftFest

class AppDataControllerSpec: QuickSpec {
    override func spec() {
        let subject = AppDataController.shared
        describe("AppDataController") {
            
            it("can get a session given a session id") {
                let sessionOne = subject.session(forSpeaker: "1")
                let sessionTwo = subject.session(forSpeaker: "3")
                
                expect(sessionOne?.title).to(equal("Keynote: TBA"))
                expect(sessionTwo?.title).to(equal("Keynote: Programming with Purpose"))
            }
            
            it("can get a list of thumbnail urls indexed by session id") {
                let speakersById = subject.speakersById
                let speakerId: Identifier<Speaker> = "1"
                
                expect(speakersById.count).to(beGreaterThanOrEqualTo(15))
                expect(speakersById.keys).to(contain(speakerId))
            }
            
            describe("JSON deserialization of the models") {
                it("deserializes the sessions") {
                    let sessions = subject.sessions
                    expect(sessions.count).to(beGreaterThanOrEqualTo(15))
                }
                
                it("deserializes the speakers") {
                    let speakers = subject.speakers
                    expect(speakers.count).to(beGreaterThanOrEqualTo(15))
                }
                
//                it("deserializes the agenda") {
//                    let agenda = subject.agenda
//                    expect(agenda.days).to(haveCount(2))
//                    expect(agenda.days.first?.date).to(equal(DateComponents(calendar: .current,
//                                                                            year: 2019,
//                                                                            month: 07,
//                                                                            day: 29,
//                                                                            hour: 0,
//                                                                            minute: 0)))
//
//                    let firstTimeslot = agenda.days.first?.timeslots.first
//                    let startTime = DateComponents(calendar: .current, hour: 9, minute: 0)
//                    let endTime = DateComponents(calendar: .current, hour: 9, minute: 45)
//
//                    expect(firstTimeslot?.startTime).to(equal(startTime))
//                    expect(firstTimeslot?.endTime).to(equal(endTime))
//                    expect(firstTimeslot?.sessionIds).to(equal(["504"]))
//                }
            }
        }
    }
}
