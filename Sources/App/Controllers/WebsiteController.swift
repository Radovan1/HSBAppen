//
//  WebsiteController.swift
//  App
//
//  Created by Radde on 2019-04-21.
//

import Vapor
import Fluent

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get("/", use: indexHandler)
        router.get("users", use: usersHandler)
        router.get("project", Project.parameter, use: projectHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        return Project.query(on: req).all().flatMap(to: View.self) { projects in
            let context = IndexContext(title: "Projects", projects: projects)
            return try req.view().render("index", context)
        }
    }
    
    func usersHandler(_ req: Request) throws -> Future<View> {
        return User.query(on: req).all().flatMap(to: View.self) { users in
            let context = UsersContext(title: "Users", users: users)
            return try req.view().render("users", context)
        }
    }
    
    func projectHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(Project.self).flatMap(to: View.self) { project in
            let context = ProjectContext(title: "Test", project: project)
            return try req.view().render("project", context)
        }
    }
}

struct IndexContext: Encodable {
    let title: String
    let projects: [Project]
}

struct UsersContext: Encodable {
    let title: String
    let users: [User]
}

struct ProjectContext: Encodable {
    let title: String
    let project: Project
}
