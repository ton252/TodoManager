//
//  Entity.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//


import Foundation


/// Parent class for all entities.
class Entity: Hashable {
    
    /// Hash value for compare entities.
    var hashValue: Int {
        get {
            return self.entityId.hashValue
        }
    }
    
    
    /// Unique entity identifer.
    var entityId: String = ""
    
    
    required public init() {}
    
    
    /// Creates an instance with identifier.
    ///
    /// - Parameter entityId: unique entity identifier.
    init(entityId: String) {
        self.entityId = entityId
    }
    
    
    /// Function to redefine it in children for proper equality.
    ///
    /// - Parameter other: entity compare with.
    /// - Returns: result of comparison.
    func equals<T>(_ other: T) -> Bool where T: Entity {
        return self.entityId == other.entityId
    }
}


/// Custom operator `==` for `Entity` and subclasses.
///
/// - Parameters:
///   - lhs: left entity to compare.
///   - rhs: right entity to compare.
/// - Returns: result of comparison.
func ==<T>(lhs: T, rhs: T) -> Bool where T: Entity {
    return lhs.equals(rhs)
}
