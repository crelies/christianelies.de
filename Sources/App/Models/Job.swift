import Foundation

struct Job: Codable {
    let title: String
    let description: String
    let apps: [JobApp]
}
