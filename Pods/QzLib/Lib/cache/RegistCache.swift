//
// Created by 强子 on 2021/4/30.
//

import SwiftUI

public struct RegistCache{

    //是否初始化
    public static let APP_INIT = "appInit"

    //注册时间
    public static let REGIST_TIME = "registTime"

    public static func hasRegist() -> Bool {
        return MyCacheUtil.getInt(REGIST_TIME) != 0
    }

    public static func getRegistDay() -> Int {
        let registTime = MyCacheUtil.getInt(REGIST_TIME)
        let now = MyDateUtil.getCurrentTimeStamp()
        return Int(floor((now - registTime).toDouble() / 24.0 / 3600.0))
    }

    public static func regist() {
        MyCacheUtil.setInt(REGIST_TIME, value: MyDateUtil.getCurrentTimeStamp())
    }

    public static func tryRegist(){
        if(hasRegist()){
            return
        }
        regist()
    }

}