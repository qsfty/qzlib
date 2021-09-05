//
// Created by 强子 on 2021/8/10.
//

import Foundation

public struct ApiResult<T>: Codable where T: Codable{
    //接口是否成功
    public var success: Bool = true
    //接口返回code
    public var code: Int = 200
    //异常信息
    public var message: String = ""
    //对象数据
    public var result: T? = nil
    //列表数据
    public var resultList: Array<T>? = nil

    public static func success(_ msg: String) -> ApiResult {
        var apiResult = ApiResult()
        apiResult.success = true
        apiResult.message = msg
        return apiResult
    }

    public static func successWithResult(_ result: T?) -> ApiResult<T> {
        var apiResult = ApiResult<T>()
        apiResult.success = true
        apiResult.result = result
        return apiResult
    }

    public static func successWithResultList(_ resultList: Array<T>?) -> ApiResult {
        var apiResult = ApiResult()
        apiResult.success = true
        apiResult.resultList = resultList
        return apiResult
    }

    public static func failure(_ msg: String) -> ApiResult<T> {
        var apiResult = ApiResult<T>()
        apiResult.success = false
        apiResult.message = msg
        return apiResult
    }

    public static func notFound() -> ApiResult<T> {
        var apiResult = ApiResult<T>()
        apiResult.success = false
        apiResult.message = "not found"
        apiResult.code = 404
        return apiResult
    }

    public static func failureWithCode(_ msg: String,code: Int) -> ApiResult<T> {
        var apiResult = ApiResult<T>()
        apiResult.success = false
        apiResult.message = msg
        apiResult.code = code
        return apiResult
    }

    public func toError<T: Codable>() -> ApiResult<T>{
        var apiResult = ApiResult<T>()
        apiResult.success = false
        apiResult.message = message
        apiResult.code = code
        return apiResult
    }

    public func toString() -> String {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)
        guard let r = data else {
            return ""
        }
        let jsonS = String(data: r, encoding: .utf8)
        return jsonS ?? ""
    }

}