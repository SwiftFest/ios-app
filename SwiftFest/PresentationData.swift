import Foundation

struct PresentationResults: Codable {
    let presentations: [Presentation]
    
    enum CodingKeys: String, CodingKey {
        case presentations = "results"
    }
}

struct Presentation: Codable {
    
    let complexity: String?
    let description: String?
    let id: Int?
    let language: String?
    let outcome: String?
    let speakers: [Int]?
    let subtype: String?
    let title: String?
    
    enum CodingKeys: CodingKey {
        case complexity
        case description
        case id
        case language
        case outcome
        case speakers
        case subtype
        case title
    }
    
}

class SwiftFestPresentations {
    
    public var presentations: [Presentation] = []
    
    func loadPresentationsFromStaticJSON() {
        
        var presentationData: Data?
        
        if let path = Bundle.main.path(forResource: "PresentationData", ofType: "json") {
            presentationData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        
        let decoder = JSONDecoder()
        let decodedPresentations = try? decoder.decode(PresentationResults.self, from: presentationData!)
        
        if let presentationResults = decodedPresentations?.presentations {
            for presentation in presentationResults {
                presentations.append(presentation)
            }
        }
    }
    
    func presentationsForSpeakerId(_ id: Int) -> [Presentation] {
        return presentations.filter({ (presentation) -> Bool in
            guard let speakers = presentation.speakers else { return false }
            return speakers.contains(id)
        })
    }
}
