//
//  UserViewModel.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation

struct UserViewModel {
    
    var id: Int
    var name: String
    var avatarUrl: String
    var profileUrl: String
    var reposUrl: String
    var followers: String
    var reposNumber: String
    var memberSince: String?
    
    init(user: User) {
        id = user.id ?? 0
        name = user.name ?? ""
        avatarUrl = user.avatarUrl ?? ""
        profileUrl = user.profileUrl ?? ""
        reposUrl = user.reposUrl ?? ""
        followers = String(user.followers ?? 0)
        reposNumber = String(user.reposNumber ?? 0)
        memberSince = "Member since: \(formmat(date: user.memberSince ?? "No date"))"
    }
    
    fileprivate mutating func formmat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let dateDate = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: dateDate)
        }
        return "No date"
    }
}

