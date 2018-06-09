import Quick
import Nimble
@testable import SwiftFest

enum Result<Value, Error> {
    case success(value: Value)
    case failure(Error)
}
struct APIError: Error {}
class SwiftFestAPIClient {
    
    func fetchAgenda(using completionHandler: @escaping (Result<Agenda, Error>) -> Void ) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: URL(string: "http://swiftfest.io/schedule.json")!) { data, _, _ in

            let agenda = try? JSONDecoder().decode(Agenda.self, from: data!)
            completionHandler(.success(value: agenda ?? Agenda(days: [])))
        }
        dataTask.resume()
    }
}

class SwiftFestAPIClientTests: QuickSpec {
    override func spec() {
        
        describe("SwiftFestAPIClient") {
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
        }
    }
}
