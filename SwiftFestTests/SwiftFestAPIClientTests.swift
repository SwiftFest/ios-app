import Nimble
import Quick
@testable import SwiftFest

class SwiftFestAPIClientTests: QuickSpec {

    override func spec() {

        let apiClient: APIClient = {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            config.urlCache = nil
            return APIClient(configuration: config)
        }()
        
        describe("SwiftFestAPIClient") {
            it("fetches the agenda from a server") {
                
                waitUntil { done in
                    
                    let apiClient = APIClient()
                    apiClient.fetchAgenda { result in
                        
                        defer { done() }
                        
                        guard case let Result.success(agenda) = result else {
                            fail("expected an agenda to be fetched")
                            return
                        }
                        
                        expect(agenda.days).to(haveCount(2))
                    }
                }
            }
            it("fetches the speakers from a server") {
                
                waitUntil { done in
                    
                    let apiClient = APIClient()
                    apiClient.fetchSpeakers { result in
                        
                        defer { done() }
                        
                        guard case let Result.success(speakers) = result else {
                            fail("expected an agenda to be fetched")
                            return
                        }
                        
                        expect(speakers.count).to(beGreaterThanOrEqualTo(20))
                    }
                }
            }
            
            it("fetches the sessions from a server") {
                
                waitUntil { done in
                    
                    let apiClient = APIClient()
                    apiClient.fetchSessions { result in
                        
                        defer { done() }
                        
                        guard case let Result.success(sessions) = result else {
                            fail("expected an agenda to be fetched")
                            return
                        }
                        
                        expect(sessions.count).to(beGreaterThanOrEqualTo(20))
                    }
                }
            }

            it("fetches the team members from a server") {
                
                waitUntil { done in
                    
                    let apiClient = APIClient()
                    apiClient.fetchTeam { result in
                        
                        defer { done() }
                        
                        guard case let Result.success(teamMembers) = result else {
                            fail("expected an agenda to be fetched")
                            return
                        }
                        
                        expect(teamMembers.count).to(beGreaterThanOrEqualTo(20))
                        expect(teamMembers.first?.firstName).to(equal("Giorgio"))
                    }
                }
            }

        }
    }
}
