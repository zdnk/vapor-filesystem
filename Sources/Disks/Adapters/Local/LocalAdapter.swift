import Foundation
import Vapor

public struct LocalAdapter {
    
    public typealias QueueFactory = () -> DispatchQueue
    
    public static var defaultQueueFactory: QueueFactory {
        return { return DispatchQueue.global(qos: .userInitiated) }
    }
    
    public let fileManager: FileManager
    public let config: Config
    public let queueFactory: QueueFactory
    
    public init(config: Config, fileManager: FileManager = .default, queueFactory: @escaping QueueFactory = LocalAdapter.defaultQueueFactory) {
        self.fileManager = fileManager
        self.config = config
        self.queueFactory = queueFactory
    }
    
    public func absolutePath(to path: String) throws -> String {
        let prefixed = try PathTools.applyPrefix(config.root, to: path)
        return URL(fileURLWithPath: prefixed).absoluteString
    }
    
}
