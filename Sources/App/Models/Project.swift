//
//  Project.swift
//  App
//
//  Created by Radde on 2019-04-21.
//

import FluentSQLite
import Vapor

final class Project: Codable {
    var id: Int?
    var name: String
    var association: String
    
    init(name: String, association: String) {
        self.name = name
        self.association = association
    }
}

extension Project: SQLiteModel {}
extension Project: Migration {}
extension Project: Content {}
extension Project: Parameter {}
