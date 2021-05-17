/*
*
* Given a time in 12-hour AM/PM format, convert it to military (24-hour) time.
* Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
* - 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock. 
*
*/

import Foundation

func time_conversion(s: String) -> String {
    let isAM = s.contains("AM")
    let isPM = s.contains("PM")

    if !isAM && !isPM {
        return ""
    }

    var s = s
    s = s.replacingOccurrences(of: "PM", with: "")
    s = s.replacingOccurrences(of: "AM", with: "")

    let components = s.components(separatedBy: ":")
    if components.count != 3 {
        return ""
    }

    guard var hour = Int(components[0]) else {
        return ""
    }

    if hour == 12, isAM {
        hour = 0
    } else if hour == 12, isPM {
        hour = 12
    } else if isPM {
        hour += 12
    }

    let hourString = (hour < 10) ? "0\(hour)" : "\(hour)"
    return "\(hourString):\(components[1]):\(components[2])"
}

print(time_conversion(s: "aa"))
print(time_conversion(s: "12:01:00PM"))
print(time_conversion(s: "12:01:00AM"))
print(time_conversion(s: "07:05:45PM"))
print(time_conversion(s: "01:02:03AM"))
