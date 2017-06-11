//
//  AObservable.swift
//  Ana
//
//  Created by Oscar Fuentes on 6/8/17.
//  Copyright © 2017 Oscar Fuentes. All rights reserved.
//

import Foundation

/**
 A wrapper class which enables the observation of an object, including attachments,
 "will set" event types, and "did set" event types.
 */

public class AObservable<T> {
    
    /**
     The function signature for the callback used during new value storage.
     
     - Parameter value: The value which conforms to the designated generic type.
     */
    
    public typealias AObservableValueFunction = (T) -> Void
    
    /**
     The current value, an element of generic type T.
     */
    
    public var value                : T {
        didSet {
            for block in self.didSetCallbacks {
                block(self.value)
            }
        }
        
        willSet {
            for block in self.willSetCallbacks {
                block(self.value)
            }
        }
    }
    
    private var didSetCallbacks: [AObservableValueFunction] = [AObservableValueFunction]()
    private var willSetCallbacks: [AObservableValueFunction] = [AObservableValueFunction]()
    
    /**
     Initializes an observable object where:
     
     - Parameter value: An intial value which conforms to the designated generic type.
     
     - Returns: An observable object which conforms to the designated generic type.
     */
    
    public init(_ value: T) {
        self.value = value
    }
    
    /**
     Property observer which is called immediately after the new value is stored.
     
     - Parameter callback: The callback to run immediately after the new value is stored.
     */
    
    public func observeDidSet(_ callback: @escaping AObservableValueFunction) {
        callback(self.value)
        self.didSetCallbacks.append(callback)
    }
    
    /**
     Property observer which is called just before the new value is stored.
     
     - Parameter callback: The callback to run just before the new value is stored.
     */
    
    public func observeWillSet(_ callback: @escaping AObservableValueFunction) {
        callback(self.value)
        self.willSetCallbacks.append(callback)
    }
    
    public func removeAllObservers() {
        self.didSetCallbacks.removeAll()
        self.willSetCallbacks.removeAll()
    }
    
}
