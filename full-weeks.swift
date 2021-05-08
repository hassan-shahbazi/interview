/* 
* Question:
*    Write a function to calculate number of full weeks between two given
*    month in a year. By defination, a full week starts from Monday and ends
*    on Sunday.
*    Don't forget to consider leap years. Also, consider the calendar is 
*    gregorian and all given parameters are valid.
*/

import Foundation

let calendar = Calendar(identifier: .iso8601)

var month_number: [String:Int] = [
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "Octobor": 10,
    "November": 11,
    "December": 12
]

func full_weeks(year: Int, start_month: String, end_month: String) -> Int {
    let start_week = get_first_monday(year: year, month: start_month)
    let end_week = get_last_sunday(year: year, month: end_month)
    let week_diff = get_weeks_between(start: start_week!, end: end_week!)
    
    return (week_diff > 0) ? week_diff : 0
}

func get_first_monday(year: Int, month: String) -> Date? {
    let monthNumber = month_number[month]!

    let date = get_components(year: year, month: monthNumber, day: 01).date!
    let day = calendar.component(.weekday, from: date)
    let daysDiff = ((calendar.firstWeekday + 7) - day) % 7
    return calendar.date(byAdding: .day, value: daysDiff, to: date)
}

func get_last_sunday(year: Int, month: String) -> Date? {
    let monthNumber = month_number[month]! + 1

    var components = get_components(year: year, month: monthNumber, day: 0)
    let day = calendar.component(.weekday, from: components.date!)
    if day != 1 {
        components.day! -= day - 1
    }
    return calendar.date(from: components)
}

func get_weeks_between(start: Date, end: Date) -> Int {
    let components = calendar.dateComponents([.weekOfYear, .day],
                                            from: start, to: end)
    if components.day! > 0 {
        return components.weekOfYear! + 1
    }
    return components.weekOfYear!
}

func get_components(year: Int, month: Int, day: Int) -> DateComponents {
    var components = DateComponents()
    components.timeZone = TimeZone(identifier: "UTC")
    components.calendar = calendar
    components.year = year
    components.month = month
    components.day = day

    return components
}


print(full_weeks(year: 2020, start_month: "January", end_month: "February") == 7)
print(full_weeks(year: 2020, start_month: "April", end_month: "September") == 25)
print(full_weeks(year: 2020, start_month: "August", end_month: "November") == 17)
print(full_weeks(year: 2021, start_month: "July", end_month: "August") == 8)
print(full_weeks(year: 2021, start_month: "November", end_month: "November") == 4)
print(full_weeks(year: 2021, start_month: "December", end_month: "November") == 0)
