import Foundation
import Vapor

protocol JSONFileServiceProtocol {
    func getMe() -> Me?
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
    func getMe() -> Me? {
        let meJSONFileURL = publicDirectoryURL.appendingPathComponent("me.json")
        guard let data = try? Data(contentsOf: meJSONFileURL) else {
            return nil
        }
        return try? JSONDecoder().decode(Me.self, from: data)
    }
}

extension JSONFileService: Service {}

extension JSONFileService: ServiceType {
    static func makeService(for container: Container) throws -> JSONFileService {
        return JSONFileService()
    }
}
