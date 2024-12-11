//
//  Double.swift
//  Sippy
//
//  Created by Syed Kashan on 12/3/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUTC(_ formate: String = "HH:mm") -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = formate
 
        return dateFormatter.string(from: date)
    }
    func getDiffrenceSeconds() -> Int? {
        let time1 = Date()
        let time2 = Date(timeIntervalSince1970: self)
        let difference = Calendar.current.dateComponents([.second], from: time1, to: time2)
        return difference.second
    }
   func getDiffrenceMintue() -> Int {
          let time = self.getDateStringFromUTC("HH:mm")
          let dateFormatter = DateFormatter()
          dateFormatter.locale = Locale(identifier: "en_US")
          dateFormatter.dateFormat = "HH:mm"
          let timeDate = dateFormatter.date(from: time)!
          let calendar = Calendar.current
          let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)
          let nowComponents = calendar.dateComponents([.hour, .minute], from: Date())

          return calendar.dateComponents([.minute], from: nowComponents, to: timeComponents).minute ?? 0
       }
    func getDiffrenceDay() -> Int {
       let time = self.getDateStringFromUTC("MM/dd/yyyy")
       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US")
       dateFormatter.dateFormat = "MM/dd/yyyy"
       let timeDate = dateFormatter.date(from: time)!
       let calendar = Calendar.current
       let timeComponents = calendar.dateComponents([.day], from: timeDate)
       let nowComponents = calendar.dateComponents([.day], from: Date())

       return calendar.dateComponents([.day], from: timeComponents, to: nowComponents).day ?? 0
    }
}
