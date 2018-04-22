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

                expect(app.staticTexts["Session Name 1"].exists).to(beTrue())
                expect(app.staticTexts["Session Name 2"].exists).to(beTrue())
                expect(app.staticTexts["Session Name 3"].exists).to(beTrue())
                expect(app.staticTexts["Session Name 4"].exists).to(beTrue())
                expect(app.staticTexts["Session Name 5"].exists).to(beTrue())

                expect(app.staticTexts["Speaker 1"].exists).to(beTrue())
                expect(app.staticTexts["Speaker 2"].exists).to(beTrue())
                expect(app.staticTexts["Speaker 3"].exists).to(beTrue())
                expect(app.staticTexts["Speaker 4"].exists).to(beTrue())
                expect(app.staticTexts["Speaker 5"].exists).to(beTrue())

                expect(app.staticTexts["9:00 AM"].exists).to(beTrue())
                expect(app.staticTexts["10:00 AM"].exists).to(beTrue())
                expect(app.staticTexts["11:00 AM"].exists).to(beTrue())
                expect(app.staticTexts["1:00 PM"].exists).to(beTrue())

            }
            
            they("a user can tap a bar button item to view the code of conduct") {
                
                app.buttons["codeOfConductButton"].tap()
                sleep(3)
                expect(app.links["Conduct"].exists).to(beTrue())
                
            }
        }
    }
}
