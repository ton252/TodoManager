//
//  PresentationModel.swift
//  TodoManager
//
//  Created by Anton Polyakov on 12/05/2018.
//  Copyright © 2018 ton252. All rights reserved.
//

import Foundation


/// Base class for Presentation Model
class PresentationModel: NSObject {
    
    
    // MARK: - Typealias
    
    typealias ErrorHandler = (Error) -> Void
    typealias StateHandler = (State) -> Void
    
    
    // MARK: - Public Properties
    
    enum State {
        case loading
        case zero(ZeroViewModel)
        case rich
    }
    
    var errorHandler: ErrorHandler?
    var updateStateHandler: StateHandler?
    
    /// Presentation Model state
    var state: State = .rich {
        didSet { updateStateHandler?(state) }
    }
    
    
    // MARK: - Initializers
    
    init(errorHandler: ErrorHandler? = .none) {
        self.errorHandler = errorHandler
        super.init()
    }
  
}
