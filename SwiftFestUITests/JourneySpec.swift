import Nimble
import Quick

class JourneySpec: QuickSpec {
    override func spec() {

        var app: XCUIApplication!

        beforeEach {
            app = XCUIApplication()
            app.launch()
        }

        describe("a conference attendee using the app") {

            they("can see the agenda for the conference") {

                expect(app.staticTexts["Keynote: Accidentally Famous"].exists).to(beTrue())
                expect(app.staticTexts["Patterns & Methodologies for Test Suite Design"].exists).to(beTrue())
                expect(app.staticTexts["Lunch"].exists).to(beTrue())
            }
            
            they("can tap a bar button item to view the code of conduct") {
                app.tabBars.buttons["Info"].tap()
                expect(app.tables.staticTexts["Code of Conduct"].exists).to(beTrue())
                app.tables/*@START_MENU_TOKEN@*/.staticTexts["Code of Conduct"]/*[[".cells.staticTexts[\"Code of Conduct\"]",".staticTexts[\"Code of Conduct\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            }
            
            they("can navigate around the app using a tab bar") {

                let tabBar = app.tabBars.element(boundBy: 0)
                let agendaButton = tabBar.buttons.element(boundBy: 0)
                let speakersListButton = tabBar.buttons.element(boundBy: 1)

                expect(app.staticTexts["Patterns & Methodologies for Test Suite Design"].exists).to(beTrue())

                speakersListButton.tap()
                
                agendaButton.tap()
            }
            
            they("can get more info about a speaker by tapping the title of their session") {

                let tabBar = app.tabBars.element(boundBy: 0)
                let speakersListButton = tabBar.buttons.element(boundBy: 1)

                speakersListButton.tap()
                
                app.staticTexts["Robert C. Martin"].firstMatch.tap()
                
                expect(app.staticTexts["Owner"].exists).to(beTrue())
            }
        }
    }
}
