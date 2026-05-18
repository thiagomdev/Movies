//
//  Extension+String.swift
//  Movies
//
//  Created by Thiago Monteiro on 4/16/26.
//

import Foundation

extension String {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: self) else {
            return self
        }
        formatter.dateFormat = "dd MMMM, yyyy"
        return formatter.string(from: date)
    }
}
