//
// Created by 强子 on 2022/2/3.
//

import Foundation

public struct MyArrayUtil {

    public static func getIdx<T: Equatable>(_ arr: [T], item: T) -> Int{
        for i in 0..<arr.count {
            if(arr[i] == item){
                return i
            }
        }
        return -1
    }

    public static func getLastIdx<T: Equatable>(_ arr: [T], item: T) -> Int{
        for i in 0..<arr.count {
            if(arr[arr.count - 1 - i] == item){
                return arr.count - 1 - i
            }
        }
        return -1
    }

    public static func str2arr(_ s: String) -> [String]{
        Array(s).map{String($0)}
    }

    public static func strSplit(_ s: String, splitter: Character) -> [String]{
        s.split(separator: splitter).map{String($0)}
    }

    public static func prependAll<T: Equatable>(_ originList:inout [T], insertList: [T]) {
        for i in 0..<insertList.count {
            let one:T = insertList[insertList.count - i - 1]
            if(!originList.contains(one)) {
                originList.insert(one, at: 0)
            }
        }
    }

    public static func appendAll<T: Equatable>(_ originList:inout [T], insertList: [T]) {
        for i in 0..<insertList.count {
            if(!originList.contains(insertList[i])) {
                originList.append(insertList[i])
            }
        }
    }


}
