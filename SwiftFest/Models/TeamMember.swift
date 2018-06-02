//
//  TeamMember.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 6/2/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import Foundation

struct TeamMember: Codable {

    enum Kind: String, Codable {
        case organizer = "team"
        case mc
        case volunteer
    }

    let id: String
    let firstName: String
    let lastName: String
    let title: String?
    let kind: Kind
    let social: [Social]
    let thumbnailUrl: String
    let bio: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "name"
        case lastName = "surname"
        case title
        case kind = "type"
        case social
        case thumbnailUrl
        case bio
    }

}

extension TeamMember: SpeakerDetailViewModel {

    var role: String? {
        return title
    }
}
