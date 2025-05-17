//
//  DateExtension.swift
//  IMDB
//
//  Created by Abhishek Shukla on 17/05/25.
//

import Foundation

extension String {
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }
    
    func toDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self.toDate())
    }

}

extension Collection where Element == Movie {
    func sortByDate() -> [Element] {
        self
            .sorted(by: { first, second in
                return first.releaseDate.toString().toDate() < second.releaseDate.toString().toDate()
            })
    }
}

