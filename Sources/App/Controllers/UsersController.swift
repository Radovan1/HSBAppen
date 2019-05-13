//
//  UsersController.swift
//  App
//
//  Created by Radde on 2019-04-21.
//

import Vapor
import Fluent

struct UsersController: RouteCollection {
    func boot(router: Router) throws {
        let projectsRoutes = router.grouped("api", "users")
        projectsRoutes.get(use: getAllHandler)
        projectsRoutes.post(User.self, use: createHandler)
        projectsRoutes.get(User.parameter, use: getAllHandler)
        projectsRoutes.delete(User.parameter, use: deleteHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func createHandler(_ req: Request, project: User) throws -> Future<User> {
        return project.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).delete(on: req).transform(to: .noContent)
    }
}
