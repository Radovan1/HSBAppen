//
//  User.swift
//  App
//
//  Created by Radde on 2019-04-21.
//

import FluentSQLite
import Vapor

final class User: Codable {
    var id: Int?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension User: SQLiteModel {}
extension User: Migration {}
extension User: Content {}
extension User: Parameter {}
