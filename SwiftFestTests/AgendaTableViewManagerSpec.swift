import Nimble
import Quick
@testable import SwiftFest

class AgendaTableViewManagerSpec: QuickSpec {
    override func spec() {
        
        var subject: AgendaViewController.TableViewManager!
        
        beforeEach {
            
            let nineAM = DateComponents(calendar: .current,
                                        timeZone: TimeZone(identifier: "UTC"),
                                        hour: 9)
            
            let twelvePM = DateComponents(calendar: .current,
                                          timeZone: TimeZone(identifier: "UTC"),
                                          hour: 12)
            
            let onePM = DateComponents(calendar: .current,
                                       timeZone: TimeZone(identifier: "UTC"),
                                       hour: 13)
            
            let sessions = [
                LocalSession(titled: "a title",
                             presentedBy: "a presenter",
                             at: nineAM),
                
                LocalSession(titled: "another title",
                             presentedBy: "another presenter",
                             at: twelvePM),
                
                LocalSession(titled: "just a title",
                             presentedBy: "just a presenter",
                             at: twelvePM),
                
                LocalSession(titled: "yet another title",
                             presentedBy: "yet another presenter",
                             at: onePM),
                
                LocalSession(titled: "and another title",
                             presentedBy: "and another presenter",
                             at: onePM)
            ]
            
            subject = AgendaViewController.TableViewManager(with: sessions)
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
                expect(cell.detailTextLabel?.text).to(equal("a presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 1))
                expect(cell.textLabel?.text).to(equal("another title"))
                expect(cell.detailTextLabel?.text).to(equal("another presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 1, section: 1))
                expect(cell.textLabel?.text).to(equal("just a title"))
                expect(cell.detailTextLabel?.text).to(equal("just a presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 2))
                expect(cell.textLabel?.text).to(equal("yet another title"))
                expect(cell.detailTextLabel?.text).to(equal("yet another presenter"))
                
                cell = subject.tableView(UITableView(), cellForRowAt: IndexPath(row: 1, section: 2))
                expect(cell.textLabel?.text).to(equal("and another title"))
                expect(cell.detailTextLabel?.text).to(equal("and another presenter"))
            }
            
        }
    }
}
