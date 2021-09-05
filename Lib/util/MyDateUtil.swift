//
// Created by 李和 on 2021/8/3.
//

import Foundation


public let weekmap = [2: "周一", 3: "周二", 4: "周三", 5: "周四", 6: "周五", 7: "周六", 1: "周日"]
public let weekgap = [2: 0, 3: 1, 4: 2, 5: 3, 6: 4, 7: 5, 1: 6]



public struct WeekInfo {

    public var idx: Int
    public var weekday: String
    public var day: String
    public var today: Bool

    public init(idx: Int, weekday: String, day: String, today: Bool) {
        self.idx = idx
        self.weekday = weekday
        self.day = day
        self.today = today
    }
}


public struct MyDateUtil {

    //时间戳（精确到秒）
    public static func getTimeStamp(_ date: Date) -> Int {
        Int(floor(date.timeIntervalSince1970))
    }
    //时间戳（精确到毫秒）
    public static func getMilliTimeStamp(_ date: Date) -> Int {
        Int(floor(date.timeIntervalSince1970 * 1000))
    }
    //当期时间戳（精确到秒）
    public static func getCurrentTimeStamp() -> Int {
        getTimeStamp(Date())
    }
    //当期时间戳（精确到毫秒）
    public static func getCurrentMilliTimeStamp() -> Int {
        getMilliTimeStamp(Date())
    }
    //格式化日期
    public static func formatDate(_ date: Date) -> String {
        format(date, format: "yyyy-MM-dd")
    }
    //格式化时间
    public static func formatTime(_ date: Date) -> String {
        format(date, format: "HH:mm:ss")
    }
    //格式化日期时间
    public static func formatDateTime(_ date: Date) -> String {
        format(date, format: "yyyy-MM-dd HH:mm:ss")
    }

    //当时日期时间
    public static func formatNowTime() -> String {
        formatDateTime(Date())
    }

    //当时日期日期
    public static func formatNowDate() -> String {
        formatDate(Date())
    }

    //格式化
    public static func format(_ date: Date, format: String) -> String {
        let c = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = format
        let date = formatter.string(from: date)
        return date
    }
    //日期转化
    public static func parse(_ str: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.init(identifier: "zh_CN")
        return dateFormatter.date(from: str)
    }

    //日期转化
    public static func parseDate(_ str: String) -> Date? {
        parse(str, format: "yyyy-MM-dd")
    }

    //日期时间转化
    public static func parseDateTime(_ str: String) -> Date? {
        parse(str, format: "yyyy-MM-dd HH:mm:ss")
    }

    //日期操作
    public static func gap(_ date: Date, unit: Calendar.Component, number: Int) -> Date {
        let cal = Calendar.current
        return cal.date(byAdding: unit, value: number, to: date)!
    }
    //某天凌晨
    public static func getStartOfDay(_ date: Date) -> Date {
        let cal = Calendar.current
        return cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
    }
    //某天夜晚
    public static func getEndOfDay(_ date: Date) -> Date {
        let cal = Calendar.current
        return cal.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
    }
    //昨天此时
    public static func getYesterday() -> Date{
        gap(Date(), unit: .day, number: -1)
    }
    //当期第几周
    public static func getWeekOfYear(_ date: Date) -> Int {
        Calendar.current.component(.weekOfYear, from: date)
    }
    //当期星期几
    public static func getWeekday(_ date: Date) -> Int {
//        let cal = Calendar.current
//        let dc = cal.dateComponents([.weekday], from: date)
//        return dc.weekday!
        let c = Calendar.current
        return c.component(.weekday, from: date)
    }

    //当期星期几
    public static func getWeekdayString(_ date: Date) -> String {
        return weekmap[getWeekday(date)]!
    }
    //获取本周第一天
    public static func getFirstDayOfWeek(_ date: Date) -> Date {
        let weekday = getWeekday(date)
        let gapFirstDay = weekgap[weekday]!
        return gap(date, unit: .day, number: -gapFirstDay)
    }
    //获取本周最后一天
    public static func getLastDayOfWeek(_ date: Date) -> Date {
        let weekday = getWeekday(date)
        let gapFirstDay = weekgap[weekday]!
        let gapLastDay = 6 - weekgap[weekday]!
        return gap(date, unit: .day, number: gapLastDay)
    }
    //获取某月第一天
    public static func set(_ date: Date, unit: Calendar.Component, value: Int) -> Date {
        let c = Calendar.current
        var component = c.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        component.setValue(value, for: unit)
        return c.date(from: component)!
    }
    public static func getFirstDayOfMonth(_ date: Date) -> Date {
        let mdate = set(date, unit: .day, value: 1)
        return getStartOfDay(mdate)
    }
    //获取某月最后一天
    public static func getLastDayOfMonth(_ date: Date) -> Date {
        let firstDayOfMonth = getFirstDayOfMonth(date)
        let nextMonth = gap(firstDayOfMonth, unit: .month, number: 1)
        return getEndOfDay(gap(nextMonth, unit: .day, number: -1))
    }

    //判断两个日期之间间隔了多少天
    public static func betweenDay(_ date1: Date, _ date2: Date) -> Int {
        let t1 = getTimeStamp(getStartOfDay(date1))
        let t2 = getTimeStamp(getStartOfDay(date2))
        return abs(t1 - t2) / 3600 / 24
    }

    //比较日期大小
    public static func isAfterDateString(target: String) -> Bool {
        guard let d = parseDate(target) else {
            return false
        }
        return isAfter(Date(), target: d)
    }

    //比较日期大小
    public static func isAfter(_ date1: Date, target: Date) -> Bool {
        getMilliTimeStamp(date1) > getMilliTimeStamp(target)
    }

    //比较日期大小
    public static func isAfter(target: Date) -> Bool {
        isAfter(Date(), target: target)
    }

    //比较日期大小
    public static func isBefore(_ date1: Date,target: Date) -> Bool {
        getMilliTimeStamp(date1) < getMilliTimeStamp(target)
    }

    //比较日期大小
    public static func isBefore(target: Date) -> Bool {
        isBefore(Date(), target: target)
    }


    //获取显示时间
    public static func getShowTime(_ date: Date) -> String {
        let now = getCurrentTimeStamp()
        let mtime = getTimeStamp(date)
        if(mtime > now){
            return "未来"
        }
        var gap = now - mtime
        if(gap < 60){
            return "\(gap)秒前"
        }
        gap = gap / 60
        if(gap < 60){
            return "\(gap)分钟前"
        }
        gap = gap / 60
        if(gap < 24) {
            return "\(gap)小时前"
        }
        gap = gap / 24
        if(gap < 5){
            return "\(gap)天前"
        }
        return formatDate(date)
    }

    //清空时间
    public static func clearTime(_ date: Date) -> Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
    }

    //gap & 清空时间
    public static func gapAndClearTime(_ date: Date, unit: Calendar.Component, number: Int) -> Date {
        let newDate = gap(date, unit: unit, number: number)
        return clearTime(newDate)
    }


    public static func isGreaterThanNow(date: String) -> Bool {
        var nowDay = formatNowDate()
        return nowDay.compare(date) == .orderedAscending
    }

    public static func isLessThanNow(date: String) -> Bool {
        var nowDay = formatNowDate()
        return nowDay.compare(date) == .orderedDescending
    }


    /**
     农历转公历
     - Parameters:
       - year:
       - month:
       - day:
     - Returns:
     */
    public static func solarToLunar(year: Int, month: Int, day: Int) -> String {

        //初始化公历日历
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)

        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .short
        formatter.calendar = lunarCalendar
        return formatter.string(from: solarDate!)
    }

    /**
     公历转农历
     - Parameters:
       - year:
       - month:
       - day:
     - Returns:
     */
    public static func solarToLunarDay(year: Int, month: Int, day: Int) -> String {

        //初始化公历日历
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)

        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
//        formatter.dateFormat = "dd"
        var x1 = formatter.string(from: solarDate!)

        let vx = x1.split(separator: "月")

        if(vx[1] == "初一"){
            return "\(vx[0].split(separator: "年")[1])月"
        }
        return "\(vx[1])"
    }

    /**
    根据参考日期及参考周数，计算目标日期所在周数
    - Parameters:
      - referDay: 参考日期（记设置周数日期）
      - refWeek: 参考周数
      - date: 目标日期
    - Returns: 目标周数
    */
    public static func getCurrentWeek(referDay: Date, refWeek: Int, date: Date) -> Int{

        let targetDate = gapAndClearTime(date, unit: .day, number:0)

        let weekday = getWeekday(referDay)
        let gapDay = weekgap[weekday]!

        //计算参考周的周一是哪一天
        let mondayDate = gapAndClearTime(referDay,unit: .day, number: -gapDay)
        //计算周一日期和目标日期差的天数
        let betweenDays = (getTimeStamp(targetDate) - getTimeStamp(mondayDate)).toDouble() / 3600 / 24
        return refWeek + floor(betweenDays / 7).toInt()
    }

    /**

     - Parameters:
       - referDay:
       - refWeek:
       - fixWeek:
     - Returns:
     */
    public static func getFixWeekPeriod(referDay: Date, refWeek: Int, fixWeek: Int) -> [WeekInfo]  {
        let weekday = getWeekday(referDay)
        let gapDay = weekgap[weekday]!
        //计算参考周的周一是哪一天
        let mondayDate = gapAndClearTime(referDay, unit: .day, number: -gapDay)
        //根据周数差统计日期
        let gapWeek = fixWeek - refWeek
        let fixMondayDate = gapAndClearTime(mondayDate, unit: .day, number: gapWeek * 7)
//        ps("refWeek", refWeek, "fixWeek", fixWeek, "refDate", referDay, "refDateMonday", mondayDate, "period", fixMondayDate)
        return getWeekPeriod(date: fixMondayDate)
    }

    /**
        获取某个日期所在周的全部日期（周一到周日）
        - Parameter date: 所在日期
        - Returns: 该星期全部日期
        */
    public static func getWeekPeriod(date: Date) -> [WeekInfo] {
        let weekday = getWeekday(date)
        let gapDay = weekgap[weekday]! * -1
        let monday = gapAndClearTime(date, unit: .day, number: gapDay)
        var result:[WeekInfo] = []
        let today = formatNowDate()
        for i in 0..<7{
            let mydate = gap(monday, unit: .day, number: i)
            result.append(
                    WeekInfo(idx: i,
                            weekday: weekmap[getWeekday(mydate)]!,
                            day: format(mydate, format: "MM-dd"),
                            today: format(mydate, format: "yyyy-MM-dd") == today
                    )
            )
        }
        return result
    }

}