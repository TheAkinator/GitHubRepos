//
//  RepoViewModel.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation

struct RepoViewModel {
    
    var id: Int
    var name: String
    var description: String
    var watchers: String
    var stars: String
    var forks: String
    
    init(repo: Repo) {
        id = repo.id ?? 0
        name = repo.name ?? ""
        description = repo.description ?? "No description"
        watchers = String(repo.watchers ?? 0)
        stars = String(repo.stars ?? 0)
        forks = String(repo.forks ?? 0)
    }
    
}
