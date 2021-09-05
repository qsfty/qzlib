//
// Created by 强子 on 2021/8/10.
//

//
// Created by 强子 on 2021/8/9.
//

import Foundation
import Alamofire
import CleanJSON


public struct BmobQueryResponse<T:Codable>: Codable{

    var results: [T]
}

public struct BmobAddResponse<T:Codable>: Codable{

    var result: T
}

public struct BmobApi {

    static var APP_ID = ""
    static var REST_KEY = ""

    public static func initBmob(appId: String, restKey: String) {
        APP_ID = appId
        REST_KEY = restKey
    }

    public static func makeHeader() -> [String:String] {
        [
            "X-Bmob-Application-Id": APP_ID,
            "X-Bmob-REST-API-Key": REST_KEY
        ]
    }


    public static func makeJsonHeader() -> [String:String] {
        [
            "X-Bmob-Application-Id": APP_ID,
            "X-Bmob-REST-API-Key": REST_KEY,
            "Content-Type": "application/json"

        ]
    }


    public static func url(_ bizName: String) -> String {
        "https://api2.bmob.cn/1/classes/\(bizName)"
    }
//
//    static func query<T>(_ bizName: String, params: [String: String], complete:@escaping (ApiResult<T>) -> Void){
//        query(bizName, params: params) { (result: ApiResult<T>) in
//            if(result.success){
//                let result = result.resultList ?? []
//                if(!result.isEmpty){
//                    complete(ApiResult.successWithResult(result[0]))
//                }
//                else{
//                    complete(ApiResult.notFound())
//                }
//            }
//            else{
//                complete(result.toError())
//            }
//        }
//    }

    public static func add<T:Codable>(_ bizName: String, model: T, complete: @escaping (AddResponse) -> Void) {
        var murl = url(bizName)
        //组装params
        //组装json
        let args = makeModelParams(model: model, forAdd: true)
        HttpUtil.postJson(url: murl,params: args, header: makeJsonHeader()) { (result: ApiResult<AddResponse>) in
            complete(result.result ?? AddResponse())
        }
    }

    public static func update<T:Codable>(_ bizName: String, model: T,complete: @escaping (UpdateResponse) -> Void) {
        var args = makeModelParams(model: model, forUpdate: true)
        var murl = url(bizName) + "/" + (args["objectId"] ?? "")
        args["objectId"] = nil
        HttpUtil.putJson(url: murl, params: args, header: makeJsonHeader()) { (result: ApiResult<UpdateResponse>) in
            complete(result.result ?? UpdateResponse())
        }
    }

    public static func delete<T:Codable>(_ bizName: String, model: T, complete: @escaping (DeleteResponse) -> Void) {
        var args = makeModelParams(model: model, forUpdate: true)
        var murl = url(bizName) + "/" + (args["objectId"] ?? "")
        args["objectId"] = nil
        HttpUtil.delete(url: murl, params: [:], header: makeJsonHeader()) { (result: ApiResult<DeleteResponse>) in
            complete(result.result ?? DeleteResponse())
        }
    }

    public static func delete(_ bizName: String, uuid: String, complete: @escaping (DeleteResponse) -> Void) {
        var murl = url(bizName) + "/" + uuid
        HttpUtil.delete(url: murl, params: [:], header: makeJsonHeader()) { (result: ApiResult<DeleteResponse>) in
            complete(result.result ?? DeleteResponse())
        }
    }

    public static func get<T:Codable>(_ bizName: String, uuid: String, complete: @escaping (ApiResult<T>) -> Void) {
        var murl = url(bizName) + "/" + uuid
        HttpUtil.get(url: murl, header: makeJsonHeader()) { (result: ApiResult<T>) in
            complete(result)
        }
    }

    public static func exists(_ bizName: String, params: [String:String], complete: @escaping (ApiResult<Bool>) -> Void) {
        query(bizName, params: params) { (r: ApiResult<BmobModel>) in
            if(r.success){
                complete(ApiResult.successWithResult((r.resultList?.count ?? 0) > 0))
            }
            else{
                complete(ApiResult.failure(r.message))
            }
        }
    }

    public static func makeModelParams<T:Codable>(model: T, forAdd: Bool = false, forUpdate: Bool = false) -> [String: String] {
        let myMirror = Mirror(reflecting: model)
        var args: [String:String] = [:]
        for case let (label?, value) in myMirror.children {
            if let v = value as? String {
                if(label != "createdAt" && label != "updatedAt"){
                    if(forAdd && label != "objectId"){
                        args[label] = v
                    }
                    if(forUpdate){
                        args[label] = v
                    }
                }

            }
        }
        return args
    }



    public static func pp<T: Codable>(data: T, complete: @escaping (ApiResult<T>) -> Void) {
        complete(ApiResult.successWithResult(data))
    }

    public static func queryOne<T: Codable>(_ bizName: String, params: [String: String], complete:@escaping (ApiResult<T>) -> Void) {
        query(bizName, params: params) { (r: ApiResult<T>) in
            if(!r.success){
                complete(r)
                return
            }
            if(r.resultList?.count == 0){
                complete(r)
                return
            }
            complete(ApiResult.successWithResult(r.resultList?[0]))
        }
    }

    public static func query<T:Codable>(_ bizName: String, params: [String: String], complete:@escaping (ApiResult<T>) -> Void){
        var murl = url(bizName)
        if(!params.isEmpty){
            let encoder = JSONEncoder()
            let data = try? encoder.encode(params)
            guard let r = data else {
                complete(ApiResult.failure("参数异常"))
                return
            }
            let jsonS = String(data: r, encoding: .utf8)
            murl += "?where=" + jsonS!.urlEncode2()
        }
        HttpUtil.get(url: murl, header: makeHeader()) { (result: ApiResult<BmobQueryResponse<T>>) in
            if(result.success){
                complete(ApiResult.successWithResultList(result.result?.results ?? []))
            }
            else{
                complete(result.toError())
            }
        }
    }


}


public struct AddResponse: Codable{

    public var error: String = ""
    public var code: String = ""

    public var objectId: String = ""
    public var createdAt: String = ""

    public func isSuccess() -> Bool{
        return objectId != "" && error == ""
    }
}

public struct UpdateResponse: Codable{

    public var error: String = ""
    public var code: String = ""

    public var updatedAt: String = ""

    public func isSuccess() -> Bool{
        return updatedAt != "" && error == ""
    }
}

public struct DeleteResponse: Codable{

    public var error: String = ""
    public var code: String = ""

    public var msg: String = ""

    public func isSuccess() -> Bool{
        return msg == "ok" && error == ""
    }
}


public class BmobModel: Codable{

    public var table: String { "" }

    public var objectId: String = ""

}
