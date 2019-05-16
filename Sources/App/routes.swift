import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let projectsController = ProjectsController()
    try router.register(collection: projectsController)
    
    let usersController = UsersController()
    try router.register(collection: usersController)
    
    let websiteController = WebsiteController()
    try router.register(collection: websiteController)
}
