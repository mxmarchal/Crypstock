//
//  CrypstockTests.swift
//  CrypstockTests
//
//  Created by Maxence Marchal on 06/12/2020.
//

import XCTest
@testable import Crypstock

class CrypstockTests: XCTestCase {

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //try removeDatabase()
    }
    
    func removeDatabase() throws {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        do {
            try FileManager.default.removeItem(at: URL(fileURLWithPath: path))
        } catch {
            XCTFail("!ERROR! Unable to remove database file.")
        }
    }
    
    func testUserDBConnection() throws {
        let user = User()
        
        XCTAssert(user.db != nil, "Database Connection isn't nil.")
    }
    
    func testUserCreateUser() throws {
        let user = User()

        let createUser = try user.createUser(inputEmail: "maxm@max", inputPassword: "max")
        XCTAssert(createUser == true, "User is created.")
    }
    
    func testUserCreateUserWrongEmail() throws {
        let user = User()

        let createUser = try user.createUser(inputEmail: "maxmax", inputPassword: "max")
        XCTAssert(createUser == false, "User isn't created (e-mail wrong).")
    }
    
    func testUserSignIn() throws {
        let user = User()

        let signInUser = try user.getUser(inputEmail: "maxm@max", inputPassword: "max")
        XCTAssert(signInUser == true, "User is signIn.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
