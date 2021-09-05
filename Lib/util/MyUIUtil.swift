//
// Created by 强子 on 2021/8/7.
//


import SwiftUI

extension UIApplication {
    public func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


public struct MyUIUtil {

    public static func  getStatusBarHeight() -> CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return height
    }

    public static func  fullWindowWidth() -> CGFloat {
        UIApplication.shared.windows.first?.frame.size.width ?? UIScreen.main.bounds.width
    }

    public static func  fullWindowHeight() -> CGFloat {
        UIApplication.shared.windows.first?.frame.size.height ?? UIScreen.main.bounds.height
    }
    
    public static func  statusHeight() -> CGFloat {
        UIApplication.shared.statusBarFrame.size.height
    }
    
    /// 是否为 IphoneX (刘海屏)系列
    public static func  isIphoneXSeries() -> Bool {
        var keyWindow = UIApplication.shared.keyWindow
        if #available(iOS 13, *), keyWindow == nil {
            keyWindow = UIApplication.shared.windows.first
        }
        if #available(iOS 11.0, *), UIDevice().userInterfaceIdiom == .phone {
            if let key = keyWindow, key.safeAreaInsets.bottom > 0 { // 不能判断 top(普通屏幕为20， 刘海屏为44),而且还要考虑屏幕旋转问题。
                return true
            }
        }

        if MyEnvUtil.isPad() {
            return true
        }
        return false
    }
    
    
    public static func  calcNavTop(_ height: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height - height
    }

    public static func  fullWidth() -> CGFloat{
        fullWindowWidth()
    }

    public static func  fullHeight() -> CGFloat {
        fullWindowHeight()
    }

    

    public static func  halfWidth() -> CGFloat {
        fullWidth() / 2
    }



    public static func  fullHeightWithOutputHeader(headerHeight: CGFloat = 50) -> CGFloat {
        return UIScreen.main.bounds.height - headerHeight - getStatusBarHeight() + (isIphoneXSeries() ? 14 : 0)
    }

    public static func  fillScreenWithOutputHeader(headerHeight: CGFloat = 50) -> CGFloat {
        return UIScreen.main.bounds.height - headerHeight - getStatusBarHeight()
    }

    public static func  halfHeight() -> CGFloat {
        UIScreen.main.bounds.height / 2
    }

    public static func  threeHeight() -> CGFloat {
        UIScreen.main.bounds.height / 3
    }

   

    public static func  gapFromTop(height: CGFloat) -> CGFloat {
        fullHeight() - height
    }

    public static func  fullHeightWithStatusBar() -> CGFloat {
        fullHeight() + getStatusBarHeight()
    }


 

    public static func  getScreenBottomHeight() -> CGFloat {
        if(isIphoneXSeries()){
            return 20
        }
        return 0
    }

    public static func  getTabbarHeight() -> CGFloat {
        50.toFloat() + getScreenBottomHeight()
    }

}
