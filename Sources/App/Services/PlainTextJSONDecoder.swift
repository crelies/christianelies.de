import Foundation
import Vapor

struct PlainTextJSONDecoder: HTTPMessageDecoder {
    func decode<D, M>(_ decodable: D.Type,
                      from message: M,
                      maxSize: Int,
                      on worker: Worker) throws -> EventLoopFuture<D> where D : Decodable, M : HTTPMessage {
        return message.body.consumeData(max: maxSize, on: worker).flatMap { data -> EventLoopFuture<D> in
            let decoder = JSONDecoder()
            let object = try decoder.decode(decodable, from: data)
            let promise = worker.eventLoop.newPromise(D.self)
            promise.succeed(result: object)
            return promise.futureResult
        }
    }
}
