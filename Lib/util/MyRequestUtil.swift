//
// Created by 强子 on 2021/8/7.
//

import Foundation

import Alamofire
import CleanJSON


public class MyRequestUtil {

    public static func  post<T:Codable>(url: String, params: [String: String], complete: @escaping (T) -> Void) {
        Alamofire.AF.request(url, method: .post, parameters: params).responseString { response in
            if let data = response.value {
                let decoder = CleanJSONDecoder()
                let rst = try! decoder.decode(T.self, from: data.data(using: .utf8)!)
                complete(rst)
            }
            else{
                ps(response.error)
            }
        }
    }

    public static func  judgeNetwork(complete: @escaping (Bool) -> Void){
        NetworkReachabilityManager(host: "www.baidu.com")?.startListening { status in
            if(status == .notReachable){
                complete(false)
            }
            else{
                complete(true)
            }
        }
    }

    public static func  onNetworkError(complete: @escaping () -> Void){
        judgeNetwork { ok in
            if(!ok){
                complete()
            }
        }
    }

    public static func  onNetworkSuccess(complete: @escaping () -> Void){
        judgeNetwork { ok in
            if(ok){
                complete()
            }
        }
    }
}