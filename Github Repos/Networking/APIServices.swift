//
//  APIServices.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class APIServices: NSObject {
    
    let BaseUrl = "https://api.github.com/"
    
    let sessionManager = Alamofire.SessionManager.default
    
    static let shared = APIServices()
    
    override init() {
        super.init()
    }
    
    func showErrorMessage(title: String, message: String, completion: (() -> Void)? = nil) {
        if let topVC = UIApplication.getTopMostViewController() {
            topVC.presentSimpleAlert(title: title, andMessage: message, onDismiss: completion)
        }
    }
    
    func isStatusCodeOk(_ response: DataResponse<Any>) -> Bool {
        switch response.response?.statusCode {
        case 200,201:
            return true
        case 401:
            self.showErrorMessage(title: "Error", message: "Unauthorized")
        case 500:
            self.showErrorMessage(title: "Error", message: "Problems with server communication")
        case 404:
            self.showErrorMessage(title: "Error", message: "Not found")
            
        default:
            if let error = response.error {
                self.showErrorMessage(title: "Error", message: error.localizedDescription)
            }
        }
        return false
    }
}

