//
//  String+.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/06/09.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

extension String {
    
    func timeFormatted() -> String {
        let substring = self.replacingOccurrences(of: "T", with: " ")
        guard let index = substring.index(of: ".") else { return "tagg fffail !" }
        let prettystring = substring.substring(to: index)
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let tempDate = format.date(from: prettystring ?? "") else { return "tagg fail ~~" }
        let interval = Int((NSDate().timeIntervalSince(tempDate)))
        
        if interval > 60 {
            let minuteInterval = interval / 60
            if minuteInterval > 60 {
                let hourInterval = minuteInterval / 60
                if hourInterval > 24 {
                    let dateInterval = hourInterval / 24
                    switch dateInterval {
                    case 1:
                        return "어제"
                    case 2 ... 30:
                        return "\(dateInterval)일전"
                    default:
                        let tempFormat = DateFormatter()
                        tempFormat.dateFormat = "MM-dd"
                        return tempFormat.string(from: tempDate)
                    }
                } else {
                    return "\(hourInterval)시간전"
                }
            } else {
                return "\(minuteInterval)분전"
            }
        } else {
            return "\(interval)초전"
        }
    }
}
