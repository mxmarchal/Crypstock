//
//  Portfolio.swift
//  Crypstock
//
//  Created by Maxence Marchal on 07/01/2021.
//

import Foundation
import SQLite

struct PortfolioModel {
    var coinName: String;
    var coinQuantity: Double;
}

class Portfolio {
    var db: Connection? = nil;
    let portfolioTable = Table("portfolio")
    let cId = Expression<Int64>("id") //id
    let cUId = Expression<Int64>("uid") //user id
    let cCoinName = Expression<String>("coinName")
    let cCoinQuantity = Expression<Double>("coinQuantity")
    
    init(db: Connection?) {
        if (db == nil) {
            print("Error: No db connection for init portfolio tables.")
        } else {
            self.db = db
            initTable()
            print("Portfolio done")
        }
    }
    
    func initTable() {
        do {
            try db!.run(portfolioTable.create(ifNotExists: true) {
                t in
                t.column(cId, primaryKey: .autoincrement)
                t.column(cUId)
                t.column(cCoinName)
                t.column(cCoinQuantity, defaultValue: 0)
            })
            print("Table 'portfolio' created")
        } catch {
            print("An error occured while creating 'portfolio' table")
        }
    }
    
    func getPortfolio(uId: Int64) -> Array<PortfolioModel> {
        var portfolioData: Array<PortfolioModel> = [];
        do {
            let query = Array(try db!.prepare(portfolioTable.filter(cUId == uId)))
            for row in query {
                let coinName = try row.get(cCoinName)
                let coinQuantity = try row.get(cCoinQuantity)
                let convertModel = PortfolioModel(coinName: coinName, coinQuantity: coinQuantity)
                portfolioData.append(convertModel)
            }
            return portfolioData
        } catch {
            print("An error occured while getting user's portfolio")
            return []
        }
    }
    
    func updatePortfolio(uId: Int64, coinName: String, value: Double) -> Bool {
        print("\(uId) \(coinName) \(value)")
        //GET from Portfolio WHERE uId & coinName
        
        do {
            let query = try db!.pluck(portfolioTable.filter(cUId == uId).filter(cCoinName == coinName))
            if query == nil {
                if (value < 1) {
                    return false;
                }
                try db!.run(portfolioTable.insert(cUId <- uId, cCoinName <- coinName, cCoinQuantity <- value))
                return true
            } else {
                let queryQuantity = try query?.get(cCoinQuantity)
                let unwrappedQuantity = queryQuantity!
                let finalQuantity = unwrappedQuantity + value
                if (finalQuantity < 0) {
                    //value can't be negative
                    return false
                } else if (finalQuantity == 0) {
                    //delete it from user portfolio
                    try db!.run(portfolioTable.filter(cUId == uId).filter(cCoinName == coinName).delete())
                    return true
                } else {
                    //Update id
                    try db!.run(portfolioTable.filter(cUId == uId).filter(cCoinName == coinName).update(cCoinQuantity <- finalQuantity))
                    return true
                }
            }
        } catch {
            print("An error occured while updating user's portfolio")
            return false
        }
    }
}
