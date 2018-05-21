import Foundation

class SwiftFestClient {
    
    //URL Session
    let session = URLSession(configuration: .default)
    
    let sessionDataUrl = URL(string: "http://swiftfest.io/sessions.json")
    let scheduleDataUrl = URL(string: "http://swiftfest.io/schedule.json")
    
    //async call to make a request to google for JSON
    func getSessionData(for url: URL, using completionHandler: @escaping ([Session]) -> Void) {
        
        let task = session.dataTask(with: url) { (responseData, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = responseData,
                let response = try? JSONDecoder().decode([Session].self, from: data) else {
                    completionHandler([])
                    return
            }
            completionHandler(response)
        }
        task.resume()
    }
    
}
