import Foundation

struct WelcomeContext: Encodable {
    let me: Me?
    let links: [Link]
}
