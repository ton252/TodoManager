//
//  Unimplemented.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation

public func requiresConcreteImplementation(
    _ fn: String = #function,
    file: StaticString = #file,
    line: UInt = #line) -> Never {
    
    fatalError("\(fn) must be overriden in subclass implementations", file: file, line: line)
}
