//
// Created by 强子 on 2021/8/9.
//

import Foundation

public func ps(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    #if DEBUG
    // This code will be run while installing from Xcode
    print("【\(MyDateUtil.formatNowTime()) APP LOG】")
    items.forEach{ data in
        print(data)
    }
    print()
    #endif
}

public func ps2(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    if(true){
        #if DEBUG
        // This code will be run while installing from Xcode
        print("临时测试【\(MyDateUtil.formatNowTime()) APP LOG】")
        items.forEach{ data in
            print(data)
        }
        print()
        #endif
    }
}


public func widgetPs(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    #if DEBUG
    print("【\(MyDateUtil.formatNowTime()) WIDGET LOG】")
    items.forEach{ data in
        print(data)
    }
    print("")
    #endif
}
