//
//  DateExtension.swift
//  3Summit
//
//  Created by Lee McCormick on 1/23/21.
//

import Foundation

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}



