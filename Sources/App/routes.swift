import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "welcome" page
    router.get { req -> EventLoopFuture<View> in
        let jsonFileService = try? req.make(JSONFileService.self)
        let me = jsonFileService?.getMe()
        return try req.view().render("welcome", ["name": me?.name, "streetAddress": me?.streetAddress, "zip": me?.zip, "city": me?.city])
    }
}
