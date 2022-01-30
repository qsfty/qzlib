//
// Created by 李和 on 2021/8/6.
//

import Foundation



public func createArray<T>(_ args: T...) -> [T] {
    var result: [T] = []
    args.forEach{ one in
        result.append(one)
    }
    return result
}

public func createSet<T: Hashable>(_ args: T...) -> Set<T> {
    var result: Set<T> = []
    args.forEach{ one in
        result.insert(one)
    }
    return result
}

public func createIntMap(_ args: Any...) -> [String:Int] {
    var result:[String:Int] = [:]
    for i in stride(from: 0, to: args.count % 2 == 1 ? args.count - 1 : args.count, by: 2) {
        result.updateValue(String(describing: args[i+1]).toInt(), forKey: String(describing: args[i]))
    }
    return result
}

public func createStringMap(_ args: Any...) -> [String:String] {
    var result:[String:String] = [:]
    for i in stride(from: 0, to: args.count % 2 == 1 ? args.count - 1 : args.count, by: 2) {
        result.updateValue(String(describing: args[i+1]), forKey: String(describing: args[i]))
    }
    return result
}


public func mapContains(_ map: [String: Bool], key: String ) -> Bool {
    guard let v = map[key] else{
        return false
    }
    return v
}