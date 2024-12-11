//
//  Array.swift
//  Sippy
//
//  Created by Kashan on 19/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

extension Array {
    func removingDuplicates<T: Equatable>(byKey key: KeyPath<Element, T>) -> [Element] {
        var result = [Element]()
        var seen = [T]()
        for value in self {
            let key = value[keyPath: key]
            if !seen.contains(key) {
                seen.append(key)
                result.append(value)
            }
        }
        return result
    }
    var middle: Element? {
        guard count != 0 else { return nil }
        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
}
