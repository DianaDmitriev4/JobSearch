//
//  String + Extens.swift
//  JobSearch
//
//  Created by User on 14.03.2024.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
