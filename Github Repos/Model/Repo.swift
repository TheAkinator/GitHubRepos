//
//  Repo.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation
import Mapper

struct Repo: Mappable {
    
    var id: Int?
    var name: String?
    var description: String?
    var watchers: Int?
    var stars: Int?
    var forks: Int?
    
    init() {}
    
    init(map: Mapper) throws {
        id = map.optionalFrom("id")
        name = map.optionalFrom("name")
        description = map.optionalFrom("description")
        watchers = map.optionalFrom("watchers")
        stars = map.optionalFrom("stargazers_count")
        forks = map.optionalFrom("forks")
    }
    
}
