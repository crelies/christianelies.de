//
//  DateFormatters.swift
//  
//
//  Created by Christian Elies on 05.01.20.
//

import Foundation

struct DateFormatters {
    static var post: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        formatter.dateStyle = .medium
        return formatter
    }()
}
