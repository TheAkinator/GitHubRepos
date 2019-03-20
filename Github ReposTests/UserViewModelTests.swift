//
//  ViewModelsTests.swift
//  Github ReposTests
//
//  Created by Raul Marques de Oliveira on 19/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import XCTest
@testable import Github_Repos

class UserViewModelTests: XCTestCase {
    
    func testFormmatDate() {
        
        var user = User()
        user.memberSince = "2018-03-13T08:07:16Z"
        
        let userViewModel = UserViewModel(user: user)
        
//        XCTAssertEqual(userViewModel.memberSince, "Member since: 13/03/1990") // fail expression
        XCTAssertEqual(userViewModel.memberSince, "Member since: 13/03/2018")
    }
    
    
}

