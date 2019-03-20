//
//  Github_ReposTests.swift
//  Github ReposTests
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import XCTest
@testable import Github_Repos

class APIServicesTests: XCTestCase {
    
    func testGetUsersService() {
        
//        let sinceCases = [129449303, 1, 200, 344, 756] // fail case
        let sinceCases = [1, 200, 344, 756, 1099]
        for since in sinceCases {
            let requestExpectation = expectation(description: "Wait for async request")
            APIServices.shared.getUsers(since: since) { (users) in
                XCTAssertTrue(!users.isEmpty, "Problem with get users service")
                
                requestExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 10) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    XCTFail("Problem with get users service")
                }
            }
        }
    }

    func testSearchUserService() {

//        let query = "asuyasjbfaianskfa" // fail case
        let query = "raul"

        let requestExpectation = expectation(description: "Wait for async request")
        APIServices.shared.searchUser(query: query) { (users) in
            XCTAssertTrue(!users.isEmpty, "Problem with search user service")

            requestExpectation.fulfill()
        }

        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Problem with search user service")
            }
        }

    }
    
    func testGetUserDetailsService() {
        
//                let user = "asuyasjbfaianskfa" // fail case
        let user = "raul"
        
        let requestExpectation = expectation(description: "Wait for async request")
        APIServices.shared.getUserDetails(user: user) { (user) in
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Problem with user details service")
            }
        }
        
    }
    
    func testGetReposService() {
        
        //                let user = "asuyasjbfaianskfa" // fail case
        let user = "raul"
        
        let requestExpectation = expectation(description: "Wait for async request")
        APIServices.shared.getRepos(user: user) { (user) in
            
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                XCTFail("Problem with user details service")
            }
        }
        
    }
}
