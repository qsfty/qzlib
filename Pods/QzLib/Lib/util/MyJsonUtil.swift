//
// Created by 强子 on 2021/8/7.
//


import SwiftUI
import CleanJSON

public class MyJsonUtil {

    public static func  print<T: Codable>(data: T){
        ps(stringify(data: data))
    }

    public static func  stringify<T: Codable>(data: T) -> String{
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            // save `encoded` somewhere
            if let json = String(data: encoded, encoding: .utf8) {
                return json
            }
        }
        return ""
    }

    public static func  parseObject<T: Codable>(data: String) -> T?{
        let decoder = CleanJSONDecoder()
        return try? decoder.decode(T.self, from: data.data(using: .utf8)!)
    }

    public static func  parseArray<T: Codable>(data: String) -> [T]{
        let decoder = CleanJSONDecoder()
        return (try? decoder.decode([T].self, from: data.data(using: .utf8)!)) ?? []
    }
}