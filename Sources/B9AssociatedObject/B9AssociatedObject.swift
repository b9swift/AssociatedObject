/*
 B9AssociatedObject.swift

 Copyright © 2020-2022 BB9z.
 https://github.com/b9swift/AssociatedObject

 The MIT License
 https://opensource.org/licenses/MIT
 */

import Foundation

/**
 Objective-C associated value wrapper for convenient use in Swift.
 It is primarily used to add attributes to existing types through extensions.

 Usage:

 ```
 private let fooAssociation = AssociatedObject<String>()
 extension SomeObject {
     var foo: String? {
         get { fooAssociation[self] }
         set { fooAssociation[self] = newValue }
     }
 }
 ```
 */
public final class AssociatedObject<T> {
    private let policy: objc_AssociationPolicy

    /// Creates an associated value wrapper.
    /// - Parameter policy: The policy for the association.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }

    /// Accesses the associated value.
    /// - Parameter index: The source object for the association.
    public subscript(index: AnyObject) -> T? {
        get {
            objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as? T
        }
        set {
            objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy)
        }
    }
}
