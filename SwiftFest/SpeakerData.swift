import Foundation

struct Speaker : Codable {
    
    let id : Int
    let firstName : String
    let lastName : String
    let title : String?
    let company : String?
    let bio : String?
    let featuredSpeaker : Bool
    let thumbnailUrl : String
    let social : [Social]?
    
    enum CodingKeys : String, CodingKey {
        case id
        case firstName = "name"
        case lastName = "surname"
        case title
        case company
        case bio
        case featuredSpeaker = "rockstar"
        case thumbnailUrl
        case social
    }
}

struct Social : Codable {
    
    enum SocialType : String {
        case twitter = "twitter"
        case website = "site"
        case github = "github"
        case linkedin = "linkedin"
        case facebook = "facebook"
    }
    
    let name : String
    let link : URL
    
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

