//
//  Hour.swift
//  YelpAssignment
//
//  Created by Ryan Dale Apo on 9/16/20.
//  Copyright © 2020 Ryan Dale Apo. All rights reserved.
//

import Foundation

struct Hour: Decodable {
    var hoursType: String?
    var open: [Open]?
    var isOpenNow: Bool?
    enum CodingKeys: String, CodingKey {
        case hoursType    =   "hours_type"
        case open         =   "open"
        case isOpenNow    =   "is_open_now"
    }
}

extension Hour {
//    enum WeekDay: String {
//        typealias RawValue = <#type#>
//
//        case 0: "Monday"
//        case 1: "Tuesday"
//        case 2: "Wednesday"
//        case 3: "Thursday"
//        case 4: "Friday"
//        case 5: "Saturday"
//        case 6: "Sunday"
//    }
    enum WeekDay: Int {
        case monday = 0
        case tuesday = 1
        case wednesday = 2
        case thursday = 3
        case friday = 4
        case saturday = 5
        case sunday = 6

       var description: String {
            switch self {
            case .monday:
                return "Monday"
            case .tuesday:
                return "Tuesday"
            case .wednesday:
                return "Wednesday"
            case .thursday:
                return "Thursday"
            case .friday:
                return "Friday"
            case .saturday:
                return "Saturday"
            case .sunday:
                return "Sunday"
          }
       }
    }
    func displayText() -> String {
        guard let open = self.open else {
            return ""
        }
        var displayText = ""
        for item in open {
            let day = WeekDay.init(rawValue: item.day ?? 0)
            let start = displayHour(hour: item.start ?? "0000")
            let end = displayHour(hour: item.end ?? "0000")
            displayText += "\(day?.description ?? "") \(start) - \(end)\n"
        }
        return displayText
    }
    func displayHour(hour: String) -> String {
        var hourVal = Int(hour) ?? 0
        var modText = "AM"
        if hourVal > 1200 {
            modText = "PM"
            hourVal -= 1200
        }
        var newHour = String(hourVal)
        while newHour.count < 4 {
            newHour = "0" + newHour
        }
        let hourText = "\(String( newHour.prefix(2))):\(String(newHour.suffix(2)))"
        return "\(hourText) \(modText)"
    }
}
