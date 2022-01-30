//
// Created by 李和 on 2021/8/4.
//

import Foundation


//随机整数
public func randomNum(_ begin: Int, _ end: Int) -> Int {
    begin + Int(arc4random()) % (end - begin)
}

public func randomNum(_ end: Int) -> Int {
    randomNum(0, end)
}

public func randString(_ len: Int) -> String {
    var str="abcdefghijklmnopqrstuvwxyz1234567890"
    var finalStr = ""
    for index in 1...len {
        let i = randomNum(0, str.count)
        finalStr += str.slice(begin: i,end: i+1)
    }
    return finalStr
}