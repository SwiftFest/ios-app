struct SessionResults: Codable {
    let sessions: [Session]
    
    enum CodingKeys: String, CodingKey {
        case sessions = "results"
    }
}
