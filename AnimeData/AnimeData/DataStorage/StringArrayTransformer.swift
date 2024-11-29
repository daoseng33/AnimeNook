//
//  StringArrayTransformer.swift
//  AnimeNook
//
//  Created by DAO on 2024/11/25.
//

import Foundation
import SwiftData

/// A value transformer that converts between an array of strings and its Data representation
/// Used for persisting string arrays in SwiftData
@objc(StringArrayTransformer)
public final class StringArrayTransformer: ValueTransformer {
    /// Specifies the class of the transformed value
    /// - Returns: NSArray class since the transformed value will be an array
    public override class func transformedValueClass() -> AnyClass {
        return NSArray.self
    }
    
    /// Indicates whether reverse transformation is allowed
    /// - Returns: true since we need bi-directional conversion
    public override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    /// Transforms a string array into its Data representation
    /// - Parameter value: The string array to transform
    /// - Returns: Data object containing the JSON representation of the array, or nil if transformation fails
    public override func transformedValue(_ value: Any?) -> Any? {
        guard let stringArray = value as? [String] else { return nil }
        return try? JSONSerialization.data(withJSONObject: stringArray)
    }
    
    /// Transforms Data back into a string array
    /// - Parameter value: The Data object containing JSON representation
    /// - Returns: The original string array, or nil if transformation fails
    public override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String]
    }
}

extension StringArrayTransformer {
    /// The name used to register this transformer in the ValueTransformer system
    static let name = NSValueTransformerName(String(describing: StringArrayTransformer.self))
    
    /// Registers this transformer with the ValueTransformer system
    /// Call this method before using the transformer, typically in your app's initialization code
    public static func register() {
        let transformer = StringArrayTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

