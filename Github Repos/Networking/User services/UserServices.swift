//
//  UserServices.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation
import Alamofire

extension APIServices {
    
    func getUsers(since: Int = 1, completion: @escaping (_ users: [User]) -> Void) {
        let endPoint = "users?since=\(since)"
        
        
        let request = sessionManager.request(BaseUrl + endPoint)
        
        request.responseJSON { (response) in
            debugPrint(response)
            
            if self.isStatusCodeOk(response) {
                if let json = response.result.value as? [NSDictionary] {
                    var users = [User]()
                    
                    for user in json {
                        if let mappedUser = User.from(user) {
                            users.append(mappedUser)
                        }
                    }
                    
                    completion(users)
                } else {
                    self.showErrorMessage(title: "Error", message: "There are no users")
                }
                
            }
            
        }
    }
    
    func getUserDetails(user: String, completion: @escaping (_ user: User) -> Void) {
        let endPoint = "users/\(user)"
        
        
        let request = sessionManager.request(BaseUrl + endPoint)
        
        request.responseJSON { (response) in
            debugPrint(response)
            
            if self.isStatusCodeOk(response) {
                if let json = response.result.value as? NSDictionary {
                    if let mappedUser = User.from(json) {
                        completion(mappedUser)
                    }
                    
                } else {
                    self.showErrorMessage(title: "Error", message: "There are no users")
                }
                
            }
            
        }
    }
    
    func searchUser(query: String, completion: @escaping (_ users: [User]) -> Void) {

        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let endPoint = "search/users?q=\(queryEncoded)"


        let request = sessionManager.request(BaseUrl + endPoint)

        request.responseJSON { (response) in
            debugPrint(response)

            if self.isStatusCodeOk(response) {
                if let json = response.result.value as? NSDictionary {
                    if let results = json["items"] as? [NSDictionary] {
                        var users = [User]()
                        
                        for user in results {
                            if let mappedUser = User.from(user) {
                                users.append(mappedUser)
                            }
                        }
                        
                        completion(users)
                    }
                }

            } else {
                self.showErrorMessage(title: "Error", message: "There are no users")
            }

        }
    }
}
