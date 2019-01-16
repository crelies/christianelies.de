import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "welcome" page
    router.get { req in
        return try req.view().render("welcome")
    }
}
