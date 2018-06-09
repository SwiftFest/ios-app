import Quick
import Nimble
@testable import SwiftFest

enum Result<Value, Error> {
    case success(value: Value)
    case failure(Error)
}


class SwiftFestAPIClient {
    
    struct APIError: Error {}
    
    private let session = URLSession(configuration: .default)
    let baseUrl: String
    
    init(baseUrl: String = "http://swiftfest.io") {
        self.baseUrl = baseUrl
    }

    func fetchAgenda(using completionHandler: @escaping (Result<Agenda, APIError>) -> Void ) {
        let dataTask = session.dataTask(with: URL(string: "\(baseUrl)/schedule.json")!) { data, _, _ in

            let agenda = try? JSONDecoder().decode(Agenda.self, from: data!)
            completionHandler(.success(value: agenda ?? Agenda(days: [])))
            
        }
        dataTask.resume()
    }
    
    func fetchSessions(using completionHandler: @escaping (Result<[Session], APIError>) -> Void ) {
        let url = URL(string: "\(baseUrl)/sessions.json")!
        let fetchDataTask = dataTask(for: url, using: completionHandler)
        fetchDataTask.resume()
    }
    
    func fetchSpeakers(using completionHandler: @escaping (Result<[Speaker], APIError>) -> Void ) {
    }
    
    func fetchTeam(using completionHandler: @escaping (Result<[TeamMember], APIError>) -> Void ) {
    }
    
}

private extension SwiftFestAPIClient {
    func dataTask<DataType: Decodable>(for url: URL,
                                       using completionHandler: @escaping (Result<[DataType], APIError>) -> Void ) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: url) { data, urlResponse, _ in
            let sessions = try? JSONDecoder().decode([DataType].self, from: data!)
            completionHandler(.success(value: sessions ?? []))
        }
        
        return dataTask
    }
}

class SwiftFestAPIClientTests: QuickSpec {
    override func spec() {
        
        fdescribe("SwiftFestAPIClient") {
            it("fetches the agenda from a server") {
                
                waitUntil { done in
                    
                    let apiClient = SwiftFestAPIClient()
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
                    
                    let apiClient = SwiftFestAPIClient()
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
                    
                    let apiClient = SwiftFestAPIClient()
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
                    
                    let apiClient = SwiftFestAPIClient()
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
