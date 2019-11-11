import Foundation
import Vapor

protocol JSONFileServiceProtocol {
    func getMe() throws -> Me
    func getLinks() throws -> [Link]
}

final class JSONFileService {
    private let directoryConfig: DirectoryConfig
    private let workDirectory: String
    private let publicPath: String
    private let publicDirectoryURL: URL
    
    init() {
        directoryConfig = DirectoryConfig.detect()
        workDirectory = directoryConfig.workDir
        publicPath = "Public"
        publicDirectoryURL = URL(fileURLWithPath: workDirectory).appendingPathComponent(publicPath, isDirectory: true)
    }
}

extension JSONFileService: JSONFileServiceProtocol {
    func getMe() throws -> Me {
        let meJSONFileURL = publicDirectoryURL.appendingPathComponent("me.json")
        let data = try Data(contentsOf: meJSONFileURL)
        let me = try JSONDecoder().decode(Me.self, from: data)
        return me
    }

    func getLinks() throws -> [Link] {
        let jsonFileURL = publicDirectoryURL.appendingPathComponent("links.json")
        let data = try Data(contentsOf: jsonFileURL)
        let links = try JSONDecoder().decode([Link].self, from: data)
        return links
    }
}

extension JSONFileService: Service {}

extension JSONFileService: ServiceType {
    static func makeService(for container: Container) throws -> JSONFileService {
        return JSONFileService()
    }
}
