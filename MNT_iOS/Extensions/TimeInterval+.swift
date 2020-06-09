//
//  TimeInterval.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/06/09.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
extension TimeInterval {
    func formattedStringFromNow(now: NSDate) -> String {
        let date = NSDate(timeIntervalSince1970: self/1000)
        let dateFormatterGet = DateFormatter()
        let timeIntervalFromNow = Int(now.timeIntervalSince(date as Date) / 3600) //86400

        switch timeIntervalFromNow {
        case 0..<1:
            let minuteIntervalFromNow = Int(now.timeIntervalSince(date as Date) / 60)
            if minuteIntervalFromNow < 1 {
                let secondIntervalFromNow = Int(now.timeIntervalSince(date as Date))
                return "\(secondIntervalFromNow)초전"
            }
            return "\(minuteIntervalFromNow)분전"
        case 1..<24:
            return "\(timeIntervalFromNow)시간전"
        case 24:
            return "어제"
        case 25..<8640:
            dateFormatterGet.dateFormat = "M월 d일"

            let calendar = Calendar.current
            let year = calendar.component(.year, from: date as Date)
            let currentYear = calendar.component(.year, from: now as Date)
            if currentYear > year {
                dateFormatterGet.dateFormat = "yy.MM.dd"
            }
            
            return dateFormatterGet.string(from: date as Date)
        default:
            dateFormatterGet.dateFormat = "yy.MM.dd"
            return dateFormatterGet.string(from: date as Date)
        }
    }
}
