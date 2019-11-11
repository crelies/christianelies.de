import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "welcome" page
    router.get { req -> EventLoopFuture<View> in
        do {
            let jsonFileService = try req.make(JSONFileService.self)
            let me = try jsonFileService.getMe()
            let links = try jsonFileService.getLinks()
            let welcomeContext = WelcomeContext(me: me, links: links)
            return try req.view().render("welcome", welcomeContext)
        } catch {
            let welcomeContext = WelcomeContext(me: nil, links: [])
            return try req.view().render("welcome", welcomeContext)
        }
    }
}
