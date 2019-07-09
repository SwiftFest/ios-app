import Nimble
import Quick
@testable import SwiftFest

class APIClientTests: QuickSpec {

    override func spec() {

        let apiClient: APIClient = {
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            config.urlCache = nil
            return APIClient(configuration: config)
        }()
        
        describe("APIClient") {
            it("fetches the agenda from a server") {

                waitUntil { done in

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
                    
                    apiClient.fetchSpeakers { result in
                        
                        defer { done() }
                        
                        guard case let Result.success(speakers) = result else {
                            fail("expected an agenda to be fetched")
                            return
                        }
                        
                        // Number of speakers is 18 as of 6/9/19
                        expect(speakers.count).to(beGreaterThanOrEqualTo(18))
                    }
                }
            }
            
            it("fetches the sessions from a server") {
                
                waitUntil { done in
                    
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

            it("fetches an image for a person and loads it into an image view") {
                waitUntil(timeout: 3) { done in
                    let imageView = UIImageView()
                    apiClient.loadPersonImage(named: "SusanBennett.jpg", into: imageView) { result in
                        defer { done() }
                        expect(result.isSuccess).to(beTrue())
                        expect(imageView.image).toNot(beNil())
                    }
                }
            }

            it("fetches multiple images for a person and loads them into a multi-image view") {
                waitUntil(timeout: 3) { done in
                    let imageView = MultiImageView()
                    imageView.setImageNames([Asset.ishShabazz.name, Asset.susanBennett.name], completionHandler: { success in
                        defer { done() }

                        expect(success).to(beTrue())
                        
                        expect(imageView.imageViews).to(haveCount(2))
                        expect(imageView.imageViews.first?.image).toNot(beNil())
                        expect(imageView.imageViews.last?.image).toNot(beNil())
                    })
                }
            }

        }
    }
}
