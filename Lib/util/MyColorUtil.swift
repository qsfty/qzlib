//
// Created by 李和 on 2021/8/5.
//

import SwiftUI

public func parseHexColor(_ hex: String) -> Color {

    var data = hex
    if(hex.starts(with: "#")){
        data = data.slice(begin: 1)
    }
    var red = 0.0, green = 0.0, blue = 0.0, opacity = 0.0
    if(data.count >= 6){
        //分割
        red = hex2decimal(data.slice(begin: 0, len: 2)).toDouble() / 255.0
        green = hex2decimal(data.slice(begin: 2, len: 2)).toDouble() / 255.0
        blue = hex2decimal(data.slice(begin: 4, len: 2)).toDouble() / 255.0
        opacity = 1.0
    }
    if(data.count == 8){
        opacity = hex2decimal(data.slice(begin: 6, len: 2)).toDouble() / 255.0
    }
    return Color(red: red, green: green, blue: blue, opacity: opacity)

}


public func makeRandomColor() -> Color{
    let cc = ["#f79b69", "#5cc997","#9ac947","#f96d6a","#b282eb", "#78cdfd", "#fc5431", "#3b98cd"]
    let c = cc[Int(arc4random() % UInt32(cc.count))]
    let red = Double(Int(c[c.index(c.startIndex, offsetBy: 1)...c.index(c.startIndex, offsetBy: 2)], radix: 16)!) / 255.0
    let green = Double(Int(c[c.index(c.startIndex, offsetBy: 3)...c.index(c.startIndex, offsetBy: 4)], radix: 16)!) / 255.0
    let blue = Double(Int(c[c.index(c.startIndex, offsetBy: 5)...c.index(c.startIndex, offsetBy: 6)], radix: 16)!) / 255.0
    return Color.init(red: red, green: green, blue: blue)
}