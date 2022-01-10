//
//  String.swift
//  CtyptoTracker
//
//  Created by Mustafo on 15/06/21.
//

import Foundation

extension String {
    
    var removedHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
