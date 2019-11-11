import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // "welcome" page
    router.get { req -> EventLoopFuture<View> in
        do {
            let httpClient = try req.client()
            let meJsonResponse = httpClient.get("https://raw.githubusercontent.com/crelies/christianelies.de/develop/Public/me.json")
            let linksJsonResponse = httpClient.get("https://raw.githubusercontent.com/crelies/christianelies.de/develop/Public/links.json")

            return Future.whenAll([meJsonResponse, linksJsonResponse], eventLoop: req.eventLoop).flatMap { httpResponse -> EventLoopFuture<(Me, [Link])> in
                let meObject = try httpResponse[0].content.decode(Me.self, using: PlainTextJSONDecoder())
                let linksObject = try httpResponse[1].content.decode([Link].self, using: PlainTextJSONDecoder())
                return meObject.and(linksObject)
            }.flatMap { me, links -> EventLoopFuture<View> in
                let welcomeContext = WelcomeContext(me: me, links: links)
                return try req.view().render("welcome", welcomeContext)
            }
        } catch {
            let welcomeContext = WelcomeContext(me: nil, links: [])
            return try req.view().render("welcome", welcomeContext)
        }
    }
}
