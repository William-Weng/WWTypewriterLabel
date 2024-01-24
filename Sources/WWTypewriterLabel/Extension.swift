//
//  Extension.swift
//  WWTypewriterLabel
//
//  Created by William.Weng on 2024/1/24.
//

import UIKit

// MARK: - String (override function)
extension String {
    
    /// [字符串下標](https://www.jianshu.com/p/1cd0e691ab7a)
    /// "subscript"[2..<5] => "bsc"
    subscript (bounds: CountableRange<Int>) -> String {
        
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        
        return String(self[start..<end])
    }
}

// MARK: - CADisplayLink (static function)
extension CADisplayLink {
    
    /// [產生CADisplayLink](https://www.hangge.com/blog/cache/detail_2278.html)
    /// - Parameters:
    ///   - target: AnyObject
    ///   - selector: Selector
    /// - Returns: CADisplayLink
    static func _build(target: AnyObject, selector: Selector) -> CADisplayLink {
        return CADisplayLink(target: target, selector: selector)
    }
}

// MARK: - CADisplayLink (function)
extension CADisplayLink {
    
    /// [執行CADisplayLink Timer](https://ios.devdon.com/archives/922)
    /// - Parameters:
    ///   - runloop: [RunLoop](https://www.jianshu.com/p/b6ffd736729c)
    ///   - mode: [RunLoop.Mode](https://www.hangge.com/blog/cache/detail_2278.html)
    func _fire(to runloop: RunLoop = .main, forMode mode: RunLoop.Mode = .default) {
        self.add(to: runloop, forMode: mode)
        self.add(to: runloop, forMode: .tracking)
    }
}
