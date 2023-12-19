//
//  Sessions.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 13/12/2023.
//

import SwiftUI
import Foundation
import CoreData

extension Sessions : Identifiable {
    private static var sessionsFetchRequest: NSFetchRequest<Sessions> {
        NSFetchRequest(entityName: "Sessions")
    }
    
    static func all() -> NSFetchRequest<Sessions> {
        let request: NSFetchRequest<Sessions> = sessionsFetchRequest
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Sessions.start_at,  ascending: false)]
        return request
    }
    
    
    var startAtFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(self.start_at))
        return dateFormatter.string(from: date)
    }
    
    var startAtWithMinutesFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let date = Date(timeIntervalSince1970: TimeInterval(self.start_at))
        return dateFormatter.string(from: date)
    }
    
    var sessionPeriod: String {
        let calendar = Calendar.current
        
        let startDate = Date(timeIntervalSince1970:TimeInterval(self.start_at))
        let endDate = Date(timeIntervalSince1970: TimeInterval(self.end_at))
        
        let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: endDate)
        
        if let hours = components.hour, let minutes = components.minute, let seconds = components.second {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return "00:00:00"
        }
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        if let midnight = calendar.date(from: components) {
            if (self.start_at > Int64(midnight.timeIntervalSince1970)) {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
}
