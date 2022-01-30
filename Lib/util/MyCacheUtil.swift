//
// Created by 强子 on 2021/8/7.
//


import SwiftUI
import CloudKit

public class MyCacheUtil {
    
    static var APP_GROUP = ""

    public class func initGroup(_ s: String) {
        APP_GROUP = s
    }

    public static func getCache() -> UserDefaults?{
        UserDefaults(suiteName: APP_GROUP)
    }

    public static func setRecordId(_ key: String, module: String, value: CKRecord.ID) {
        set(key, module: module, value: value.recordName)
    }

    public static func getRecordId(_ key: String, module: String) -> CKRecord.ID?{
        let data = get(key, module: module)
        if(data == ""){
            return nil
        }
        return CKRecord.ID(recordName: data)
    }

    public static func  set(_ key: String, value: String) {
        getCache()?.set(value, forKey: key)
    }

    public static func  setInt(_ key: String, value: Int) {
        set(key, value: "\(value)")
    }

    public static func  set(_ key: String, module: String, value: String){
        set(mkstring(key, module: module), value: value)
    }

    public static func  get(_ key: String, defaultValue: String = "") -> String{
        guard let k = UserDefaults(suiteName: APP_GROUP)?.string(forKey: key) else {
            return defaultValue
        }
        return k
    }

    public static func  get(_ key: String, module: String, defaultValue: String = "") -> String{
        get(mkstring(key, module: module), defaultValue: defaultValue)
    }

    public static func  getInt(_ key: String) -> Int{
        let k = get(key)
        if(k == ""){
            return 0
        }
        return k.toInt()
    }

    public static func getBoolean(_ key: String) -> Bool{
        let k = get(key)
        return k == "1"
    }

    public static func getBoolean(_ key: String, module: Any) -> Bool{
        let k = get(mkstring(key, module: module))
        return k == "1"
    }

    public static func  setBoolean(_ key: String, value: Bool){
        set(key, value: value ? "1" : "0")
    }

    public static func  setBoolean(_ key: String,module: Any, value: Bool){
        set(mkstring(key, module: module), value: value ? "1" : "0")
    }

    public static func  exist(_ key: String) -> Bool {
        get(key) != ""
    }

    public static func  exist(_ key: String, module: String) -> Bool {
        get(mkstring(key, module: module)) != ""
    }


    public static func  isConfig(_ key: String) -> Bool {
        let v = get(key)
        return v != "" && v != "0"
    }

    public static func  remove(_ key: String) {
        getCache()?.removeObject(forKey: key)
    }

    public static func  remove(_ key: String, module: String) {
        getCache()?.removeObject(forKey: mkstring(key, module: module))
    }

    public static func  setJson<T:Codable>(_ key: String,data:T) {
        set(key, value: MyJsonUtil.stringify(data: data))
    }

    public static func  getJsonObject<T:Codable>(_ key: String) -> T? {
        let oldData = get(key)
        if(oldData == ""){
            return nil
        }
        return MyJsonUtil.parseObject(data: oldData)
    }

    public static func  getJsonArray<T: Codable>(_ key: String) -> [T] {
        let oldData = get(key)
        return MyJsonUtil.parseArray(data: oldData)
    }

    public static func  setJson<T:Codable>(_ key: String, module: Any, data:T) {
        set(mkstring(key, module: module), value: MyJsonUtil.stringify(data: data))
    }

    public static func  getJsonObject<T:Codable>(_ key: String, module: Any) -> T? {
        getJsonObject(mkstring(key, module: module))
    }

    public static func  getJsonArray<T: Codable>(_ key: String, module: Any) -> [T] {
        getJsonArray(mkstring(key, module: module))
    }

    public static func  mkstring(_ key: String, module: Any) -> String{
        "\(key)___\(module)"
    }

}
