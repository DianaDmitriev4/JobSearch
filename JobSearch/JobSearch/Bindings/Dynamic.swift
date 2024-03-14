//
//  Dynamic.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import Foundation

final class Dynamic<T> {
    // MARK: - Properties
    typealias Listener = ((T) -> Void)
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - Initialization
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Methods
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
