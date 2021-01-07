//
//  User.swift
//  Crypstock
//
//  Created by Maxence Marchal on 24/12/2020.
//

import Foundation
import SQLite

struct UserModel {
    var uId: Int64?;
    var email: String?;
}

class User: Identifiable {
    //Database
    var db: Connection? = nil;
    let usersTable = Table("users")
    let cId = Expression<Int64>("id")
    let cEmail = Expression<String>("email")
    let cPassword = Expression<String>("password")
    
    //Data
    var userData: UserModel? = nil;
    
    //PortfolioManager
    var portfolioManager: Portfolio? = nil;
    
    
    init() {
        initDatabase()
        initTables()
    }
    
    func initDatabase() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            self.db = try Connection("\(path)/crypstock.sqlite3")
            print("DB created/opened")
        } catch {
            self.db = nil
            print("An error occured while opening database")
        }
    }
    
    func initTables() {

        do {
            //Users table
            try db!.run(usersTable.create(ifNotExists: true) { t in
                t.column(cId, primaryKey: .autoincrement)
                t.column(cEmail, unique: true, check: cEmail.like("%@%"))
                t.column(cPassword)
            })
            print("Table 'users' created")
            print("Users done")
            
            //Init other tables
            self.portfolioManager = Portfolio(db: db)
        } catch {
            print("An error occured while creating 'users' table")
        }
    }
    
    func getUser(inputEmail: String, inputPassword: String) -> Bool {
        do {
            let query = try db!.pluck(usersTable.filter(cEmail == inputEmail).filter(cPassword == inputPassword))
            if query == nil {
                return false
            }
            let id = try query?.get(cId)
            let email = try query?.get(cEmail)
            userData = UserModel(uId: id ?? nil, email: email ?? nil)
            return true
        } catch {
            print("An error occured while selec user from 'users' table")
            return false
        }
    }
    
    func createUser(inputEmail: String, inputPassword: String) {
        do {
            let rowId = try db!.run(usersTable.insert(cEmail <- inputEmail, cPassword <- inputPassword))
            print("User \(inputEmail) added. (RowID: \(rowId))")
        } catch {
            print("An error occured while inserting user into 'users' table")
        }
    }
    
    func getUserPortfolio() -> Array<Any>? {
        do {
            if (userData == nil) {
                return nil;
            }
            let uId = userData?.uId
            if (uId == nil) {
                return nil;
            } else {
                let unwrappedUId = uId!
                let res = portfolioManager?.getPortfolio(uId: unwrappedUId)
                return res;
            }
        } catch {
            return nil;
        }
    }
}
