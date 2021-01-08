//
//  DB.swift
//  Crypstock
//
//  Created by Maxence Marchal on 24/12/2020.
//

import Foundation
import SQLite3

class DB {
    let path: String = "crypstock.sqlite"
    var dbPointer:OpaquePointer?
    
    init() {
        dbPointer = initDatabase()
    }
    
    func initDatabase() -> OpaquePointer? {
        let dbFileURL = try! FileManager.default.url(for:. documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        var db: OpaquePointer? = nil
        if sqlite3_open(dbFileURL.path, &db) != SQLITE_OK {
            print("Error, unable to open database")
            return nil
        } else {
            print("Done. Database exist and open")
            return db
        }
    }
    
    func createTable(query: String) {
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, query, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Table created")
            } else {
                print("Table unable to create.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
}
