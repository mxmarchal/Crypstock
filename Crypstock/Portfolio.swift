//
//  Portfolio.swift
//  Crypstock
//
//  Created by Maxence Marchal on 07/01/2021.
//

import Foundation
import SQLite

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
    
    func getPortfolio(uId: Int64) -> Array<Any>? {
        do {
            let query = Array(try db!.prepare(portfolioTable.filter(cUId == uId)))
            print("[DEBUG] Get Portfolio here")
            //let query = Array(portfolioTable.filter(cUId == uId))
            print(query)
            return []
        } catch {
            print("An error occured while getting user's portfolio")
            return nil
        }
    }
    
    
    
    
}
