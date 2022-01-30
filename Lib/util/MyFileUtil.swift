//
// Created by 强子 on 2021/10/10.
//

import Foundation

public struct MyFileUtil {

    //创建文件夹
    public static func mkdir(dir: URL) -> Bool{
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
            return true
        } catch let error as NSError {
            ps(error.localizedDescription)
            return false
        }
    }

    public static func touch(file: URL) -> Bool{
        do {
            return try FileManager.default.createFile(atPath: file.path, contents: nil)
        } catch let error as NSError {
            ps(error.localizedDescription)
            return false
        }
    }

    public static func write(file: URL, data: String) -> Bool{
        do {
            try data.write(to: file, atomically: false, encoding: .utf8)
            return true
        } catch let error as NSError {
            ps(error.localizedDescription)
            return false
        }
    }

    public static func binaryWrite(file: URL, data: Data) -> Bool{
        do {
            try data.write(to: file)
            return true
        } catch let error as NSError {
            ps("写入失败", error.localizedDescription)
            return false
        }
    }

    public static func append(file: URL, data: String) -> Bool{
        do {
            try data.data(using: .utf8)?.append(to: file)
            return true
        } catch let error as NSError {
            ps(error.localizedDescription)
            return false
        }
    }

    public static func appendLine(file: URL, data: String) -> Bool{
        append(file: file, data: data.appending("\n"))
    }


    public static func listDir(dir: URL) -> [URL] {
        do {
            return try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.fileSizeKey])
        }
        catch let error as NSError {
            ps(error.localizedDescription)
        }
        return []
    }

    public static func listDir2(dir: URL) -> [String] {
        do {
            return try FileManager.default.contentsOfDirectory(atPath: dir.path)
        }
        catch let error as NSError {
            ps(error.localizedDescription)
        }
        return []
    }

    public static func newPath(parent: URL, path: String) -> URL{
        parent.appendingPathComponent(path)
    }

    public static func binaryRead(url: URL) -> Data? {
        do {
            let k = try Data(contentsOf: url)
            return k
        }
        catch let err as NSError{
            ps("load data error", err)
        }
        return nil
    }

    public static func rootFile(name: String) -> URL {
        FileManager.sharedContainerURL().appendingPathComponent(name)
    }

    public static func deleteRoomFile(name: String) -> Bool {
        let url = rootFile(name: name)
        do {
            let fileManager = FileManager.default
            if(fileManager.fileExists(atPath: url.path)){
                try fileManager.removeItem(at: url)
                return true
            }
            return false
        } catch let error as NSError {
            return false
        }
    }

}

extension FileManager {
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: "group.cn.qsfty.timetable.file"
        )!
    }
}


extension Data {
    public func append(to url: URL) throws {
        if let fileHandle = try? FileHandle(forWritingTo: url) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: url)
        }
    }
}