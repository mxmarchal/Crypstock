//
//  User.swift
//  Crypstock
//
//  Created by Maxence Marchal on 24/12/2020.
//

import Foundation
import SQLite

class User: Identifiable {
    //Database
    var db: Connection? = nil;
    let usersTable = Table("users")
    let cId = Expression<Int64>("id")
    let cEmail = Expression<String>("email")
    let cPassword = Expression<String>("password")
    
    //Data
    var email: String? = ""
    
    init() {
        initDatabase()
        initTable()
        print("done")
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
    
    func initTable() {

        do {
            try db!.run(usersTable.create(ifNotExists: true) { t in
                t.column(cId, primaryKey: .autoincrement)
                t.column(cEmail, unique: true, check: cEmail.like("%@%"))
                t.column(cPassword)
            })
            print("Table 'users' created")
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
            email = try query?.get(cEmail) //Set email to my data
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
}
