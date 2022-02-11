//
// Created by 强子 on 2022/1/30.
//

import Foundation

public class MyValidUtil {

    public static func isPassword(password:String) -> Bool {
        let passwordRule = "^[0-9A-Za-z]{6,8}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        if regexPassword.evaluate(with: password) == true {
            return true
        }else
        {
            return false
        }
    }

}