//
// Created by 强子 on 2021/8/10.
//

import Foundation
import CleanJSON
import Alamofire

public class HttpUtil {


    public static func get<T: Codable>(url: String,header: [String:String]? = nil, complete: @escaping (ApiResult<T>) -> ()) {
        Alamofire.AF.request(url, headers: header == nil ? nil : HTTPHeaders.init(header!)).responseString { resp in
            if(resp.error != nil){
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            guard let data = resp.value else {
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            let decoder = CleanJSONDecoder()
            let rst:T = try! decoder.decode(T.self, from: data.data(using: .utf8)!)
            complete(ApiResult.successWithResult(rst))
        }
    }



    public static func post<T: Codable>(url: String,params: [String: String], header: [String:String]? = nil, complete: @escaping (ApiResult<T>) -> ()) {
        Alamofire.AF.request(url,method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: header == nil ? nil : HTTPHeaders.init(header!)).responseString { resp in
            if(resp.error != nil){
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            guard let data = resp.value else {
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            let decoder = CleanJSONDecoder()
            let rst:T = try! decoder.decode(T.self, from: data.data(using: .utf8)!)
            complete(ApiResult.successWithResult(rst))
        }
    }

    public static func postJson<T: Codable>(url: String,params: [String: String], header: [String:String]? = nil, complete: @escaping (ApiResult<T>) -> ()) {
        Alamofire.AF.request(url,method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: header == nil ? nil : HTTPHeaders.init(header!)).responseString { resp in
            if(resp.error != nil){
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            guard let data = resp.value else {
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            let decoder = CleanJSONDecoder()
            let rst:T = try! decoder.decode(T.self, from: data.data(using: .utf8)!)
            complete(ApiResult.successWithResult(rst))
        }
    }

    public static func putJson<T: Codable>(url: String,params: [String: String], header: [String:String]? = nil, complete: @escaping (ApiResult<T>) -> ()) {
        Alamofire.AF.request(url,method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: header == nil ? nil : HTTPHeaders.init(header!)).responseString { resp in
            if(resp.error != nil){
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            guard let data = resp.value else {
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            let decoder = CleanJSONDecoder()
            let rst:T = try! decoder.decode(T.self, from: data.data(using: .utf8)!)
            complete(ApiResult.successWithResult(rst))
        }
    }


    public static func delete<T: Codable>(url: String,params: [String: String], header: [String:String]? = nil, complete: @escaping (ApiResult<T>) -> ()) {
        Alamofire.AF.request(url,method: .delete, parameters: params, encoder: JSONParameterEncoder.default, headers: header == nil ? nil : HTTPHeaders.init(header!)).responseString { resp in
            if(resp.error != nil){
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            guard let data = resp.value else {
                complete(ApiResult.failureWithCode("接口异常", code: 500))
                return
            }
            let decoder = CleanJSONDecoder()
            let rst:T = try! decoder.decode(T.self, from: data.data(using: .utf8)!)
            complete(ApiResult.successWithResult(rst))
        }
    }
}