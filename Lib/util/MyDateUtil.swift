//
// Created by 李和 on 2021/8/3.
//

import Foundation


public let weekmap = [2: "周一", 3: "周二", 4: "周三", 5: "周四", 6: "周五", 7: "周六", 1: "周日"]
public let weekname_map = [2: "周一", 3: "周二", 4: "周三", 5: "周四", 6: "周五", 7: "周六", 1: "周日"]
public let weekgap = [2: 0, 3: 1, 4: 2, 5: 3, 6: 4, 7: 5, 1: 6]

public let monday_weekgap = [2: 0, 3: 1, 4: 2, 5: 3, 6: 4, 7: 5, 1: 6]
public let sunday_weekgap = [2: 1, 3: 2, 4: 3, 5: 4, 6: 5, 7: 6, 1: 0]


public struct VacationConfig: Codable {
    public var adjustVacation: Bool = false
    public var adjustWork: Bool = false
    public var vacationName: String = ""
    public var fromDate: String = ""

    public init() {

    }

    public init(vacationName: String) {
        self.adjustVacation = true
        self.vacationName = vacationName
    }

    public init(vacationName: String, fromDate: String) {
        self.adjustWork = true
        self.vacationName = vacationName
        self.fromDate = fromDate
    }
}

public struct WeekInfo: Codable {

    public var idx: Int = 0
    public var weekday: String = ""
    public var day: String = ""
    public var today: Bool = false
    public var date: String = ""
    public var vacationConfig: VacationConfig = VacationConfig()

    public init(){

    }

    public init(idx: Int, weekday: String, day: String, today: Bool, date: String) {
        self.idx = idx
        self.weekday = weekday
        self.day = day
        self.today = today
        self.date = date
    }
}


public struct MyDateUtil {

    public static func splitYearMonth(_ data: String) -> [Int] {
        let ts = MyArrayUtil.strSplit(data, splitter: "-")
        if(ts.count == 2){
            return [ts[0].toInt(), ts[1].toInt()]
        }
        return [-1, -1]
    }

    public static func joinYearMonth(_ year: Int, _ month: Int) -> String {
        "\(year)-\(month)"
    }

    public static func getCurrentYear() -> Int {
        let d = Date.init()
        return Calendar.current.component(.year, from: d)
    }

    public static func getCurrentMonth() -> Int {
        let d = Date.init()
        return Calendar.current.component(.month, from: d)
    }

    public static func getCurrentDay() -> Int {
        let d = Date.init()
        return Calendar.current.component(.day, from: d)
    }

    public static func getCurrentWeek() -> Int {
        let d = Date.init()
        return Calendar.current.component(.weekday, from: d)
    }

    public static func parseTimestamp(_ timestamp: Int) -> Date {
        Date.init(timeIntervalSince1970: TimeInterval(timestamp))
    }

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
    public static func formatTime(_ date: Date? = nil) -> String {
        var mydate: Date? = date
        if(date == nil){
            mydate = Date()
        }
        return format(mydate!, format: "HH:mm:ss")
    }

    public static func formatShortMonth(_ date: Date? = nil) -> String {
        var mydate: Date? = date
        if(date == nil){
            mydate = Date()
        }
        return format(mydate!, format: "yyyy-MM")
    }

    //格式化时间
    public static func formatShortTime(_ date: Date? = nil) -> String {
        var mydate: Date? = date
        if(date == nil){
            mydate = Date()
        }
        return format(mydate!, format: "HH:mm")
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
    public static func gapDay(date: Date, num: Int) -> Date{
        gap(date, unit: .day, number: num)
    }
    //第几周
    public static func getWeekOfYear(_ date: Date) -> Int {
        Calendar.current.component(.weekOfYear, from: date)
    }
    //星期几
    public static func getWeekday(_ date: Date) -> Int {
        let c = Calendar.current
        return c.component(.weekday, from: date)
    }

    //星期几
    public static func getWeekdayIndex(_ date: Date) -> Int {
        let c = Calendar.current
        return c.component(.weekday, from: date)
    }

    //当前年
    public static func getYear(_ date: Date) -> Int {
        getComponent(date, unit: .year)
    }

    //当前月
    public static func getMonth(_ date: Date) -> Int {
        getComponent(date, unit: .month)
    }

    //当前日
    public static func getDay(_ date: Date) -> Int {
        getComponent(date, unit: .day)
    }

    //获取单位
    public static func getComponent(_ date: Date, unit: Calendar.Component) -> Int {
        let c = Calendar.current
        return c.component(unit, from: date)
    }

    //间距
    public static func getWeekdayGap(_ date: Date) -> Int {
        weekgap[getWeekday(date)]!
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

    public static func isAfterOrEqual(_ date1: Date, target: Date) -> Bool {
        getMilliTimeStamp(date1) >= getMilliTimeStamp(target)
    }

    //比较日期大小
    public static func isAfter(target: Date) -> Bool {
        isAfter(Date(), target: target)
    }

    //比较日期大小
    public static func isAfterOrEqual(target: Date) -> Bool {
        isAfterOrEqual(Date(), target: target)
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

    //判断某个日期是否在某个区间范围内
    public static func isBetween(_ date: String, beginDate: String, endDate: String) -> Bool {
        if(beginDate == "" || endDate == "" || date == ""){
            return false
        }
        let d1 = MyDateUtil.parseDate(date)!
        let d2 = MyDateUtil.parseDate(beginDate)!
        let d3 = MyDateUtil.parseDate(endDate)!
        return isAfterOrEqual(d1, target: d2) && isAfterOrEqual(d3, target: d1)
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

    public static func getSecondsByTime(time: String) -> Int {
        if(time.count != 5){
            return 0
        }
        return time.slice(begin: 0,end: 2).toInt() * 60 + time.slice(begin: 3).toInt()
    }

    public static func isTimeAfter(_ time1: String, time2: String) -> Bool {
        getSecondsByTime(time: time1) > getSecondsByTime(time: time2)
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

    //根据两个秒级时间戳获取间隔天数
    public static func getBetweenDays(_ d1: Int,_ d2: Int) -> Int {
        floor(abs(d1 - d2).toDouble() * 1.0 / 60.0 / 60.0 / 24.0).toInt()
    }

    //获取某个日期所在周的第一天
    public static func getFirstDayGapFromDate(date: Date, isMondayFirst: Bool) -> Int {
        let weekday = getWeekday(date)
        if(isMondayFirst){
            return monday_weekgap[weekday]!
        }
        return sunday_weekgap[weekday]!
    }

    //获取某个日期所在周的第一天
    public static func getFirstDayFromDate(date: Date, isMondayFirst: Bool) -> Date {
        let gap = getFirstDayGapFromDate(date: date, isMondayFirst: isMondayFirst)
        return gapDay(date: date, num: -1 * gap)
    }

    //获取某个日期所在周那一周日期
    public static func getWeekDatesFromSomeDate(date: Date, isMondayFirst: Bool) -> [WeekInfo] {
        let firstDay = getFirstDayFromDate(date: date, isMondayFirst: isMondayFirst)
        var result:[WeekInfo] = []
        let today = MyDateUtil.formatNowDate()
        for i in 0..<7{
            var day = gapDay(date: firstDay, num: i)
            var weekInfo = WeekInfo()
            weekInfo.idx = i
            weekInfo.weekday = weekname_map[getWeekday(day)]!
            weekInfo.day = MyDateUtil.format(day, format: "MM-dd")
            weekInfo.date = MyDateUtil.formatDate(day)
            weekInfo.today = today == weekInfo.date
            result.append(weekInfo)
        }
        return result
    }

    //根据日期x第y周，判断当前日期是第几周
    public static func getTargetWeek(refDate: Date, refWeek: Int, targetDate: Date, isMondayFirst: Bool) -> Int {
        let refFirstDay = clearTime(getFirstDayFromDate(date: refDate, isMondayFirst: isMondayFirst))
        let targetFirstDay = clearTime(getFirstDayFromDate(date: targetDate, isMondayFirst: isMondayFirst))
        let betweenDays = getBetweenDays(targetFirstDay.timestamp(), refFirstDay.timestamp()).toDouble()
        return refWeek + floor(betweenDays / 7).toInt()
    }

    public static func getWeekDatesFromRefWeek(refDate: Date, refWeek: Int, targetWeek: Int, isMondayFirst: Bool) -> [WeekInfo] {
        let refFirstDay = getFirstDayFromDate(date: refDate, isMondayFirst: isMondayFirst)
        let betweenDays = (targetWeek - refWeek) * 7
        let targetDate = gapDay(date: refFirstDay, num: betweenDays)
        return getWeekDatesFromSomeDate(date: targetDate, isMondayFirst: isMondayFirst)
    }


}

extension Date {

    public func toDateString() -> String{
        MyDateUtil.formatDate(self)
    }

    public func toDateTimeString() -> String{
        MyDateUtil.formatDateTime(self)
    }

    public func timestamp() -> Int {
        MyDateUtil.getTimeStamp(self)
    }

    public func milliTimestamp() -> Int {
        MyDateUtil.getMilliTimeStamp(self)
    }
}