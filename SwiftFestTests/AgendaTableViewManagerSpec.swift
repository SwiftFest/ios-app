import Nimble
import Quick
@testable import SwiftFest

extension Session {
    static func forTesting(withId id: String, title: String) -> Session {
        return Session(complexity: nil,
                       description: "description",
                       id: id,
                       language: nil,
                       outcome: nil,
                       speakers: ["0"],
                       subtype: nil,
                       title: title)
    }
}

class AgendaTableViewManagerSpec: QuickSpec {
    override func spec() {
        
        var subject: AgendaViewController.TableViewManager!
        
        beforeEach {
            
            let nineAM = DateComponents(calendar: .current,
                                        timeZone: .current,
                                        hour: 9)
            
            let tenAM = DateComponents(calendar: .current,
                                       timeZone: .current,
                                       hour: 10)
            
            let twelvePM = DateComponents(calendar: .current,
                                          timeZone: .current,
                                          hour: 12)
            
            let onePM = DateComponents(calendar: .current,
                                       timeZone: .current,
                                       hour: 13)
            
            let twoPM = DateComponents(calendar: .current,
                                       timeZone: .current,
                                       hour: 14)
            
            let dayOne = DateComponents(year: 2018, month: 06, day: 18)
            let agenda = Agenda(days: [
                Agenda.Day(date: dayOne, timeslots: [
                    Agenda.Timeslot(startTime: nineAM, endTime: tenAM, sessionIds: ["000"]),
                    Agenda.Timeslot(startTime: onePM, endTime: twoPM, sessionIds: ["003", "004"]),
                    Agenda.Timeslot(startTime: twelvePM, endTime: onePM, sessionIds: ["001", "002"])
                    ])
                ])
            
            let sessions: [Session] = [
                Session.forTesting(withId: "000", title: "a title"),
                Session.forTesting(withId: "001", title: "another title"),
                Session.forTesting(withId: "002", title: "just a title"),
                Session.forTesting(withId: "003", title: "yet another title"),
                Session.forTesting(withId: "004", title: "and another title"),
            ]
            
            subject = AgendaViewController.TableViewManager(agenda: agenda, sessions: sessions)
        }
        
        describe("the agenda table view's manager") {
            it("has a section for each time block") {
                let sections = subject.numberOfSections(in: UITableView())
                expect(sections).to(equal(3))
            }
            
            it("has a section header for each time block which is in ascending order") {
                var sectionHeader = subject.tableView(UITableView(), titleForHeaderInSection: 0)
                expect(sectionHeader).to(equal("9:00 AM"))
                
                sectionHeader = subject.tableView(UITableView(), titleForHeaderInSection: 1)
                expect(sectionHeader).to(equal("12:00 PM"))
                
                sectionHeader = subject.tableView(UITableView(), titleForHeaderInSection: 2)
                expect(sectionHeader).to(equal("1:00 PM"))
            }
            
            it("has one or many sessions for each time block") {
                var rows = subject.tableView(UITableView(), numberOfRowsInSection: 0)
                expect(rows).to(equal(1))
                
                rows = subject.tableView(UITableView(), numberOfRowsInSection: 1)
                expect(rows).to(equal(2))
                
                rows = subject.tableView(UITableView(), numberOfRowsInSection: 2)
                expect(rows).to(equal(2))
            }
            
            it("renders each session as a cell") {
                var cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell.textLabel?.text).to(equal("a title"))
//                expect(cell.detailTextLabel?.text).to(equal("a presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 1))
                expect(cell.textLabel?.text).to(equal("another title"))
//                expect(cell.detailTextLabel?.text).to(equal("another presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 1, section: 1))
                expect(cell.textLabel?.text).to(equal("just a title"))
//                expect(cell.detailTextLabel?.text).to(equal("just a presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 2))
                expect(cell.textLabel?.text).to(equal("yet another title"))
//                expect(cell.detailTextLabel?.text).to(equal("yet another presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 1, section: 2))
                expect(cell.textLabel?.text).to(equal("and another title"))
//                expect(cell.detailTextLabel?.text).to(equal("and another presenter"))
            }
        }
    }
}
