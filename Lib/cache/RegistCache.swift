//
// Created by 强子 on 2021/4/30.
//

import SwiftUI

public struct RegistCache{

    //是否初始化
    public static let APP_INIT = "appInit"

    //用户id
    public static let USER_ID = "userId"

    //注册时间
    public static let REGIST_TIME = "registTime"


    public static func setUserId(_ uuid: String){
        MyCacheUtil.set(USER_ID, value: uuid)
    }

    public static func getUserId() -> String {
        MyCacheUtil.get(USER_ID)
    }


    public static func isManager() -> Bool {
        MyCacheUtil.get(USER_ID) == Array.init(repeating: "8", count: 16).joined()
    }

    public static func hasRegist() -> Bool {
        return MyCacheUtil.getInt(REGIST_TIME) != 0
    }

    public static func getRegistDay() -> Int {
//        if(true){
//            return getRegistTime()
//        }
        let registTime = getRegistTime()
        let now = MyDateUtil.getCurrentTimeStamp()
        return Int(floor((now - registTime).toDouble() / 24.0 / 3600.0))
    }

    public static func getRegistTime() -> Int {
        MyCacheUtil.getInt(REGIST_TIME)
    }

    public static func regist(time: Int = 0) {
        MyCacheUtil.setInt(REGIST_TIME, value: time == 0 ? MyDateUtil.getCurrentTimeStamp() : time)
    }

    public static func tryRegist(){
        if(hasRegist()){
            return
        }
        regist()
    }

}