//
// Created by 李和 on 2021/8/5.
//

import Foundation

public struct MyDataUtil {


    public static func toggleValue<T:Equatable>(_ array:inout Set<T>, value: T) {
        if(array.contains(value)){
            array.remove(value)
        }
        else{
            array.insert(value)
        }
    }
}