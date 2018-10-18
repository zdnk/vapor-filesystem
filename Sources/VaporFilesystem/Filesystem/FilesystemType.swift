import Foundation
import Vapor

public protocol FilesystemType {
    
    var adapter: FilesystemAdapter { get }
    var worker: Container { get }
    
    func has(file: String, options: FileOptions?) -> Future<Bool>
    func read(file: String, options: FileOptions?) -> Future<Data>
    func listContents(of: String, recursive: Bool, options: FileOptions?) -> Future<[String]>
    func metadata(of: String, options: FileOptions?) -> Future<FileMetadata>
    func size(of: String, options: FileOptions?) -> Future<Int>
    func timestamp(of: String, options: FileOptions?) -> Future<Date>
    func write(data: Data, to: String, options: FileOptions?) -> Future<()>
//    func write(file: String, to: String) -> Future<()>
    func update(data: Data, to: String, options: FileOptions?) -> Future<()>
//    func update(file: String, to: String) -> Future<()>
    func put(data: Data, to: String, options: FileOptions?) -> Future<()>
//    func put(file: String, to: String) -> Future<()>
    func move(file: String, to: String, options: FileOptions?) -> Future<()>
    func copy(file: String, to: String, options: FileOptions?) -> Future<()>
    func delete(file: String, options: FileOptions?) -> Future<()>
    func delete(directory: String, options: FileOptions?) -> Future<()>
    func create(directory: String, options: FileOptions?) -> Future<()>
    
}

extension FilesystemType {
    
    func rename(file: String, to: String, options: FileOptions?) -> Future<()> {
        guard var path = URL(string: file) else {
            return worker.eventLoop.newFailedFuture(error: FilesystemError.invalidPath)
        }
        
        path.deleteLastPathComponent()
        path.appendPathComponent(to)
        
        return self.move(file: file, to: path.absoluteString, options: options)
    }
    
    func rename(file: String, to: String) -> Future<()> {
        return rename(file: file, to: to, options: nil)
    }
    
    func has(file: String) -> Future<Bool> {
        return has(file: file, options: nil)
    }
    
    func read(file: String) -> Future<Data> {
        return read(file: file, options: nil)
    }
    
    func listContents(of: String, recursive: Bool) -> Future<[String]> {
        return listContents(of: of, recursive: recursive, options: nil)
    }
    
    func metadata(of: String) -> Future<FileMetadata> {
        return metadata(of: of, options: nil)
    }
    
    func size(of: String) -> Future<Int> {
        return size(of: of, options: nil)
    }
    
    func timestamp(of: String) -> Future<Date> {
        return timestamp(of: of, options: nil)
    }
    
    func write(data: Data, to: String) -> Future<()> {
        return write(data: data, to: to, options: nil)
    }
    
    func update(data: Data, to: String) -> Future<()> {
        return update(data: data, to: to, options: nil)
    }
    
    func put(data: Data, to: String) -> Future<()> {
        return put(data: data, to: to, options: nil)
    }
    
    func move(file: String, to: String) -> Future<()> {
        return move(file: file, to: to, options: nil)
    }
    
    func copy(file: String, to: String) -> Future<()> {
        return copy(file: file, to: to, options: nil)
    }
    
    func delete(file: String) -> Future<()> {
        return delete(file: file, options: nil)
    }
    
    func delete(directory: String) -> Future<()> {
        return delete(directory: directory, options: nil)
    }
    
    func create(directory: String) -> Future<()> {
        return create(directory: directory, options: nil)
    }
    
}
