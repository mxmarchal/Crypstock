//
//  PortfolioTests.swift
//  CrypstockTests
//
//  Created by Maxence Marchal on 08/01/2021.
//

import XCTest
@testable import Crypstock

class PortfolioTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuyBTC() throws {
        let user: User = User()
        let coin: Coin = Coin(name: "Bitcoin", shortName: "BTC", colors: CoinColors(primary: "#ffffff", secondary: "#000000"), values: [230.0, 217.23], currentValue: 240, quantity: nil)

        
        _ = try user.deleteUser(inputEmail: "maxbuy@max")
        _ = try user.createUser(inputEmail: "maxbuy@max", inputPassword: "max")
        _ = try user.getUser(inputEmail: "maxbuy@max", inputPassword: "max")
        let buy = user.updateUserPotfolio(coin: coin, value: 23.0, isSell: false)
        XCTAssert(buy == true, "BTC bougth.")
    }
    
    func testSellBTC() throws {
        let user: User = User()
        let coin: Coin = Coin(name: "Bitcoin", shortName: "BTC", colors: CoinColors(primary: "#ffffff", secondary: "#000000"), values: [230.0, 217.23], currentValue: 240, quantity: nil)
        
        _ = try user.deleteUser(inputEmail: "maxbuy@max")
        _ = try user.createUser(inputEmail: "maxbuy@max", inputPassword: "max")
        _ = try user.getUser(inputEmail: "maxbuy@max", inputPassword: "max")
        _ = user.updateUserPotfolio(coin: coin, value: 23.0, isSell: false)
        
        let sell = user.updateUserPotfolio(coin: coin, value: 23.0, isSell: true)
        XCTAssert(sell == true, "BTC sold.")
    }
    
    
    func testSellNegativeBTC() throws {
        let user: User = User()
        let coin: Coin = Coin(name: "Bitcoin", shortName: "BTC", colors: CoinColors(primary: "#ffffff", secondary: "#000000"), values: [230.0, 217.23], currentValue: 240, quantity: nil)
        
        _ = try user.deleteUser(inputEmail: "maxbuy@max")
        _ = try user.createUser(inputEmail: "maxbuy@max", inputPassword: "max")
        _ = try user.getUser(inputEmail: "maxbuy@max", inputPassword: "max")
        let buy = user.updateUserPotfolio(coin: coin, value: 50.0, isSell: true)
        XCTAssert(buy == false, "BTC not sold (not enough).")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
