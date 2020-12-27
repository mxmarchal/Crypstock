//
//  UserManagement.swift
//  Crypstock
//
//  Created by Maxence Marchal on 20/12/2020.
//

import Foundation
import GRDB

class UserManagement {
    var id: Int!
    var username: String!
    var dbQueue: DatabaseQueue!
    
    init() throws {
        do {
            self.dbQueue = try DatabaseQueue.init(path: "./users.sqlite") //migth be a shitty implementation, need to get more information about to implement it well, will do the work for now
            print("done")
        } catch let error {
            print(error)
        }
    }
}
