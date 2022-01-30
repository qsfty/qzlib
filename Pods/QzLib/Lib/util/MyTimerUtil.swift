//
// Created by 强子 on 2021/8/7.
//

import SwiftUI


public class MyTimerUtil {

    public static func  sleep(_ time: TimeInterval, complete: @escaping () -> Void) -> Timer{
        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
            complete()
        }
    }

    public static func  after(complete: @escaping () -> Void) -> Timer{
        sleep(0.1, complete: complete)
    }

    public static func  immediate(complete: @escaping () -> Void) -> Timer{
        sleep(0.2, complete: complete)
    }

    public static func  short(complete: @escaping () -> Void) -> Timer{
        sleep(0.5, complete: complete)
    }

    public static func  sleep1(complete: @escaping () -> Void) -> Timer{
        sleep(1, complete: complete)
    }

    public static func  sleep2(complete: @escaping () -> Void) -> Timer{
        sleep(2, complete: complete)
    }

    public static func  sleep3(complete: @escaping () -> Void) -> Timer{
        sleep(3, complete: complete)
    }

    public static func  schedule(_ time: TimeInterval, complete: @escaping (Timer) -> Void) -> Timer {
        Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
            complete(timer)
        }
    }

    public static func  schedule1(complete: @escaping (Timer) -> Void) -> Timer {
        schedule(1, complete: complete)
    }

    public static func  animation(complete: @escaping () -> Void) {
        withAnimation(.easeInOut(duration: 0.8)){
            complete()
        }
    }

    public static func  animation2(complete: @escaping () -> Void) {
        withAnimation(.easeInOut(duration: 0.2)){
            complete()
        }
    }

    public static func  animation5(complete: @escaping () -> Void) {
        withAnimation(.linear(duration: 0.5)){
            complete()
        }
    }

    public static func  scheduleWithTimes(_ time: TimeInterval,times: Int, complete: @escaping (Timer) -> Void) -> Timer {
        var mtimes = 0
        return Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
            mtimes += 1
            if(mtimes == times){
                timer.invalidate()
                ps("timer over")
            }
            else{
                complete(timer)
            }
        }
    }

    public static func  animation1(complete: @escaping () -> Void) {
        withAnimation(.linear(duration: 0.8)){
            complete()
        }
    }

    public static func  async(comlete: @escaping () -> Void) {
        DispatchQueue.main.async{
            comlete()
        }
    }

}