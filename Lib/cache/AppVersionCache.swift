//
// Created by 强子 on 2022/1/30.
//

import Foundation
import QzLib

public struct AppVersionCache {

    public static let KEY = "latestVersion"

    public static func setLatestVersion(_ version: AppVersion) {
        MyCacheUtil.setJson(KEY, data: version)
    }

    public static func getLatestVersion() -> AppVersion {
        guard let v: AppVersion = MyCacheUtil.getJsonObject(KEY) else {
            return AppVersion(version: "0.0.1")
        }
        return v
    }
}