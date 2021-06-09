//
//  String+Date.swift
//  Willing
//
//  Created by Kim on 2021/05/30.
//  Copyright © 2021 Kim SuJin. All rights reserved.
//

import Foundation

extension String {
    func toDateString() -> String {
        guard self.count == 12 else { return self }
        let year = self.prefix(4)
        var month = self.prefix(6).suffix(2)
        var day = self.prefix(8).suffix(2)
        var hour = self.prefix(10).suffix(2)
        var min = self.suffix(2)
        
        if month.prefix(1) == "0" {
            month = month.suffix(1)
        }
        
        if day.prefix(1) == "0" {
            day = day.suffix(1)
        }
        
        if hour.prefix(1) == "0" {
            hour = hour.suffix(1)
        }
        
        if min.prefix(1) == "0" {
            min = min.suffix(1)
        }
        
        return "\(year)년 \(month)월 \(day)일 \(hour)시 \(min)분"
        
    }
    
    func toSimpleDateTimeString() -> String {
        guard self.count == 12 else { return self }
        let year = self.prefix(4).suffix(2)
        let month = self.prefix(6).suffix(2)
        let day = self.prefix(8).suffix(2)
        let hour = self.prefix(10).suffix(2)
        let min = self.suffix(2)
        
        return "\(year)/\(month)/\(day)  \(hour):\(min)"
    }
}
