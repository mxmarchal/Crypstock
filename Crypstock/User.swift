//
//  User.swift
//  Crypstock
//
//  Created by Maxence Marchal on 24/12/2020.
//

import Foundation
import SQLite

class User: Identifiable {
    var db: Connection? = nil;
    let usersTable = Table("users")
    let id = Expression<Int64>("id")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    
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
            print("DB created")
        } catch {
            self.db = nil
            print("An error occured while opening database")
        }
    }
    
    func initTable() {

        do {
            try db!.run(usersTable.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(email, unique: true, check: email.like("%@%"))
                t.column(password)
            })
            print("Table 'users' created")
        } catch {
            print("An error occured while creating 'users' table")
        }
    }
    
    func getUser(email: String) {
    }
    
    func createUser(inputEmail: String, inputPassword: String) {
        do {
            let rowId = try db!.run(usersTable.insert(email <- inputEmail, password <- inputPassword))
            print("User \(inputEmail) added. (RowID: \(rowId))")
        } catch {
            print("An error occured while inserting user into 'users' table")
        }
    }
    
    /*
     let persons = read()
             for p in persons
             {
                 if p.id == id
                 {
                     return
                 }
             }
             let insertStatementString = "INSERT INTO person (Id, name, age) VALUES (?, ?, ?);"
             var insertStatement: OpaquePointer? = nil
             if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                 sqlite3_bind_int(insertStatement, 1, Int32(id))
                 sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
                 sqlite3_bind_int(insertStatement, 3, Int32(age))
                 
                 if sqlite3_step(insertStatement) == SQLITE_DONE {
                     print("Successfully inserted row.")
                 } else {
                     print("Could not insert row.")
                 }
             } else {
                 print("INSERT statement could not be prepared.")
             }
             sqlite3_finalize(insertStatement)
     */
}
