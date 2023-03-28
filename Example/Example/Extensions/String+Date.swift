//
//  String+Date.swift
//  Example
//
//  Created by David Bui on 23/03/2023.
//

import Foundation

extension String {

    func formatDate(format: String = "dd MMM yyyy") -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatterInput.date(from: self) else { return "Invalid date string" }
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMM yyyy"
        return dateFormatterOutput.string(from: date)
    }
}
