//
//  ReposServices.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 19/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation
import Alamofire

extension APIServices {
    
    func getRepos(user: String, completion: @escaping (_ repos: [Repo]) -> Void) {
        let endPoint = "users/\(user)/repos"
        
        
        let request = sessionManager.request(BaseUrl + endPoint)
        
        request.responseJSON { (response) in
            debugPrint(response)
            
            if self.isStatusCodeOk(response) {
                if let json = response.result.value as? [NSDictionary] {
                    var repos = [Repo]()
                    
                    for repo in json {
                        if let mappedRepo = Repo.from(repo) {
                            repos.append(mappedRepo)
                        }
                    }
                    
                    completion(repos)
                } else {
                    self.showErrorMessage(title: "Error", message: "There are no repos")
                }
                
            }
            
        }
    }
}
