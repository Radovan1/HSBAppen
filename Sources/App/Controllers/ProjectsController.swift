//
//  ProjectsController.swift
//  App
//
//  Created by Radde on 2019-04-21.
//

import Vapor
import Fluent
import Logging

struct ProjectsController: RouteCollection {
    func boot(router: Router) throws {
        let projectsRoutes = router.grouped("api", "projects")
        projectsRoutes.get(use: getAllHandler)
        projectsRoutes.post(Project.self, use: createHandler)
        projectsRoutes.get(Project.parameter, use: getAllHandler)
        projectsRoutes.delete(Project.parameter, use: deleteHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Project]> {
        let logger = try req.make(Logger.self)
        logger.info("getAllHandler called")
        return Project.query(on: req).all()
    }
    
    func createHandler(_ req: Request, project: Project) throws -> Future<Project> {
        let logger = try req.make(Logger.self)
        logger.info("createHandler called")
        return project.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<Project> {
        let logger = try req.make(Logger.self)
        logger.info("getHandler called")
        return try req.parameters.next(Project.self)
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        let logger = try req.make(Logger.self)
        logger.info("deleteHandler called")
        return try req.parameters.next(Project.self).delete(on: req).transform(to: .noContent)
    }
}
