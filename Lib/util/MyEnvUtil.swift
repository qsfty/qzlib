//
// Created by 强子 on 2021/8/7.
//

//
//  MyEnvUtil.swift
//  yushu
//
//  Created by 强子 on 2020/11/29.
//

import SwiftUI


public class MyEnvUtil {

    //private static let isTestFlight = NSBundle.mainBundle().appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    public static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

    // This can be used to add debug statements.
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }



    public static var envName: String {
        if(isDebug){
            return "开发版本\(AppVersionApi.currentVersionString)"
        }
        else if(isTestFlight){
            return "内测版本\(AppVersionApi.currentVersionString)"
        }
        return "\(AppVersionApi.currentVersionString)"
    }

    public static var isTestFlightMode: Bool {
        return !isDebug && isTestFlight
    }

    public class func isPad() -> Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    public static func  isIOS14() -> Bool {
        if #available(iOS 14.0, *) {
            return true
        }
        return false
    }

    public static func  copy(data: String) {
        UIPasteboard.general.string = data
    }

    public static func  getClipboardData() -> String {
        UIPasteboard.general.string ?? ""
    }
}
