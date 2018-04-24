import Foundation

struct SpeakerResults : Codable {
    let speakers : [Speaker]
    
    enum CodingKeys : String, CodingKey {
        case speakers = "results"
    }
}

struct Speaker: Codable {
    
    let id : Int
    let firstName : String
    let lastName : String
    let title : String?
    let company : String?
    let bio : String?
    let featuredSpeaker : Bool?
    let thumbnailUrl : String?
    let social : [Social]?
    
    enum CodingKeys : String, CodingKey {
        case id
        case firstName = "name"
        case lastName = "surname"
        case company
        case title
        case bio
        case featuredSpeaker = "rockstar"
        case thumbnailUrl
        case social
    }
}

struct Social: Codable {
    
    let name: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case link
    }
    
    enum SocialType: String {
        case twitter = "twitter"
        case website = "site"
        case github = "github"
        case linkedin = "linkedin"
        case facebook = "facebook"
    }
    
    var socialType : SocialType? {
        switch name {
            case "twitter":
                return .twitter
            case "site":
                return .website
            case "github":
                return .github
            case "linkedin":
                return .linkedin
            case "facebook":
                return .facebook
            default:
                return nil
        }
    }
}

