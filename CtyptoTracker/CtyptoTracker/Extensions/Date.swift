//
//  Date.swift
//  CtyptoTracker
//
//  Created by Mustafo on 15/06/21.
//

import Foundation

extension Date {
    
    init(coinGeckoDate: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoDate) ?? Date()
        self = date
        
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString()-> String {
        shortFormatter.string(from: self)
    }
}
