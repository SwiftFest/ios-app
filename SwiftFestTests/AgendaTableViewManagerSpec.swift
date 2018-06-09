import Nimble
import Quick
@testable import SwiftFest

extension Session {
    static func forTesting(withId id: Identifier<Session>, title: String) -> Session {        
        return Session(complexity: "nil",
                       description: "description",
                       id: id,
                       outcome: "",
                       speakers: ["0"],
                       subtype: "nil",
                       title: title)
    }
}

class AgendaTableViewManagerSpec: QuickSpec {
    override func spec() {
        
        var tableView: UITableView!
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
            
            let threePM = DateComponents(calendar: .current,
                                         timeZone: .current,
                                         hour: 15)
            
            let dayOne = DateComponents(year: 2018, month: 06, day: 18)
            let agenda = Agenda(days: [
                Agenda.Day(
                    date: dayOne,
                    tracks: [
                        Agenda.Track(title: "Track 1", color: "#FF0000"),
                        Agenda.Track(title: "Track 2", color: "#00FF00"),
                        Agenda.Track(title: "Workshops", color: "#0000FF"),
                    ],
                    timeslots: [
                        Agenda.Timeslot(startTime: nineAM, endTime: tenAM, sessionIds: ["000"]),
                        Agenda.Timeslot(startTime: twelvePM, endTime: onePM, sessionIds: ["001", "002"]),
                        Agenda.Timeslot(startTime: onePM, endTime: twoPM, sessionIds: ["003", "004", "005"]),
                        Agenda.Timeslot(startTime: twoPM, endTime: threePM, sessionIds: ["006", "007"]),
                        ]),
                ])
            
            let sessions: [Session] = [
                Session.forTesting(withId: "000", title: "a title"),
                Session.forTesting(withId: "001", title: "another title"),
                Session.forTesting(withId: "002", title: "just a title"),
                Session.forTesting(withId: "003", title: "yet another title"),
                Session.forTesting(withId: "004", title: "and another title"),
                Session.forTesting(withId: "005", title: "and one more title"),
                Session.forTesting(withId: "006", title: "lunch"),
                Session.forTesting(withId: "007", title: ""),
            ]

            let nib = UINib(nibName: "\(RibbonTableViewCell.self)", bundle: Bundle(for: RibbonTableViewCell.self))

            tableView = UITableView()
            tableView.register(nib, forCellReuseIdentifier: "SessionCell")
            
            subject = AgendaViewController.TableViewManager(agenda: agenda, sessions: sessions, speakersById: [:], viewController: nil)
        }
        
        describe("the agenda table view's manager") {
            it("has a section for each time block") {
                let sections = subject.numberOfSections(in: UITableView())
                expect(sections).to(equal(4))
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
                expect(rows).to(equal(3))
            }
            describe("cell rendering behavior") {
             
                it("renders each session as a cell") {
                    var cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("a title"))
                    expect(cell?.secondaryTextLabel.text).to(equal("9:00 AM - 10:00 AM"))
                    expect(cell?.tertiaryTextLabel.text).to(equal("Virginia Wimberly Theater"))
                    
                    cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("another title"))
                    expect(cell?.secondaryTextLabel.text).to(equal("12:00 PM - 1:00 PM"))
                    expect(cell?.tertiaryTextLabel.text).to(equal("Virginia Wimberly Theater"))
                    
                    cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 1)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("just a title"))
                    expect(cell?.secondaryTextLabel.text).to(equal("12:00 PM - 1:00 PM"))
                    expect(cell?.tertiaryTextLabel.text).to(equal("Nancy and Edward Roberts Studio Theater"))
                    
                    cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 2)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("yet another title"))
                    expect(cell?.secondaryTextLabel.text).to(equal("1:00 PM - 2:00 PM"))
                    expect(cell?.tertiaryTextLabel.text).to(equal("Virginia Wimberly Theater"))
                    
                    cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 2)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("and another title"))
                    expect(cell?.secondaryTextLabel.text).to(equal("1:00 PM - 2:00 PM"))
                    expect(cell?.tertiaryTextLabel.text).to(equal("Nancy and Edward Roberts Studio Theater"))
                    
                    cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 2)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("and one more title"))
                    expect(cell?.secondaryTextLabel.text).to(equal("1:00 PM - 2:00 PM"))
                    expect(cell?.tertiaryTextLabel.text).to(equal("Carol Dean Theatre"))
                }
                
                it("special cases lunch based on the case-insensitive name of the session") {
                    let cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 3)) as? RibbonTableViewCell
                    expect(cell?.mainTextLabel.text).to(equal("lunch"))
                    expect(cell?.tertiaryTextLabel.text).to(equal(""))
                }
                
                it("special cases sessions without names") {
                    let cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 3)) as? RibbonTableViewCell
                    expect(cell).to(beNil())
                }
            }
        }
    }
}
