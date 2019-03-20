//
//  User.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation
import Mapper

struct User: Mappable {
    
    var id: Int?
    var name: String?
    var avatarUrl: String?
    var profileUrl: String?
    var reposUrl: String?
    var followers: Int?
    var reposNumber: Int?
    var memberSince: String?
    
    init() {}
    
    init(map: Mapper) throws {
        id = map.optionalFrom("id")
        name = map.optionalFrom("login")
        avatarUrl = map.optionalFrom("avatar_url")
        profileUrl = map.optionalFrom("url")
        reposUrl = map.optionalFrom("repos_url")
        followers = map.optionalFrom("followers")
        reposNumber = map.optionalFrom("public_repos")
        memberSince = map.optionalFrom("created_at")
    }
    
}
