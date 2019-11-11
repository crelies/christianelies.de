import Foundation

struct Me: Codable {
    let name: String
    let streetAddress: String
    let zip: String
    let city: String
    let job: Job
    let tags: [String]
}
