//
//  Box.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import Foundation

public class Box<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?

    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
