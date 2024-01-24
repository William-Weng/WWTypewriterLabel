//
//  WWTypewriterLabel.swift
//  WWTypewriterLabel
//
//  Created by William.Weng on 2024/1/24.
//

import UIKit

// MARK: - 打字機顯示功能
open class WWTypewriterLabel: UILabel {
    
    private var timer: CADisplayLink?
    private var currentIndex: UInt = 0
    private var loopCount: UInt = 0
    private var stringType: StringType = .general(nil)
    private var loopType: LoopType = .once
}

// MARK: - 公開函式
public extension WWTypewriterLabel {
    
    /// [開始啟動打字機顯示功能](https://www.jianshu.com/p/8de0f02abb78)
    /// - Parameters:
    ///   - fps: [顯示的速度](https://zh.wikipedia.org/zh-tw/帧率)
    ///   - currentIndex: [從第幾個字開始](https://cloud.tencent.com/developer/article/1640760)
    ///   - stringType: [文字類型](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-attributedstring-或-nsattributedstring-實現多種樣式組合的文字-dba0794c09de)
    ///   - loopType: [顯示次數](https://www.hackingwithswift.com/articles/113/nsattributedstring-by-example)
    func start(fps: Int = 10, currentIndex: UInt = 0, stringType: StringType, loopType: LoopType = .once) {
        initSetting(currentIndex: currentIndex, stringType: stringType, loopType: loopType)
        timerStart(fps: fps)
    }
    
    /// [停止打字機顯示](https://blog.csdn.net/ajwdwl/article/details/52851043)
    /// - Parameter isShowFull: 是否完整顯示
    func stop(isShowFull: Bool = false) {
        
        currentIndex = 0
        loopCount = 0
        timerStop()
        
        if (isShowFull) { showFullAciton() }
    }
}

// MARK: - 公開Enum
public extension WWTypewriterLabel {
    
    /// [文字類型](https://anny86023.medium.com/uilabel不同的顏色與字型-nsmutableattributedstring屬性應用-7e1d93357dc9)
    enum StringType {
        case general(_ string: String?)                             // 一般文字
        case attributed(_ attributedString: NSAttributedString?)    // 帶有屬性的文字
    }
    
    /// [顯示次數](https://juejin.cn/post/6844903642047184904)
    enum LoopType {
        case once                                                   // 一次
        case count(_ loopCount: UInt)                               // 很多次
        case infinity                                               // 一直重覆
    }
}

// MARK: - 小工具
private extension WWTypewriterLabel {
    
    /// 打字機顯示功能
    /// - Parameter sender: CADisplayLink
    @objc func typing(_ sender: CADisplayLink) {
        switch stringType {
        case .general(let string): generalStringAction(string, loopType: loopType)
        case .attributed(let attributedString): attributedStringAction(attributedString, loopType: loopType)
        }
    }
    
    /// [處理一般文字](https://www.jianshu.com/p/6b051274708e)
    /// - Parameters:
    ///   - string: String?
    ///   - loopType: LoopType
    func generalStringAction(_ string: String?, loopType: LoopType) {
        
        guard let string = string,
              currentIndex < string.count
        else {
            loopAction(loopType); return
        }
        
        let length = Int(currentIndex) + 1
        let text = string[0..<length]
        
        self.text = text
        currentIndex += 1
    }
    
    /// [處理有Attribute的文字](https://github.com/lixiaojun94/XJTypeLabel)
    /// - Parameters:
    ///   - attributedString: NSAttributedString?
    ///   - loopType: LoopType
    func attributedStringAction(_ attributedString: NSAttributedString?, loopType: LoopType) {
        
        guard let attributedString = attributedString,
              currentIndex < attributedString.length
        else {
            loopAction(loopType); return
        }
        
        let stringRange = NSRange(location: 0, length: Int(currentIndex) + 1)
        let attributedText = attributedString.attributedSubstring(from: stringRange)
        
        self.attributedText = attributedText
        currentIndex += 1
    }
}

// MARK: - 小工具
private extension WWTypewriterLabel {
    
    /// 初始化數值
    /// - Parameters:
    ///   - currentIndex: UInt
    ///   - stringType: StringType
    ///   - loopType: LoopType
    func initSetting(currentIndex: UInt, stringType: StringType, loopType: LoopType) {
        
        self.currentIndex = currentIndex
        self.stringType = stringType
        self.loopType = loopType
        
        if case let .count(loopCount) = loopType { self.loopCount = loopCount }
    }
    
    /// 開始啟動Timer
    /// - Parameter fps: Int
    func timerStart(fps: Int = 10) {
        timerStop()
        timer = CADisplayLink(target: self, selector: #selector(self.typing(_:)))
        timer?.preferredFramesPerSecond = fps
        timer?._fire()
    }
    
    /// 停止Timer
    func timerStop() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 顯示次數的處理
    /// - Parameter loopType: LoopType
    func loopAction(_ loopType: LoopType) {
        
        switch loopType {
        case .once: timerStop()
        case .infinity: self.currentIndex = 0
        case .count(_):
            self.currentIndex = 0
            self.loopCount -= 1
            if (loopCount == 0) { stop() }
        }
    }
    
    /// 顯示完整字串
    func showFullAciton() {
        switch stringType {
        case .general(let text): self.text = text
        case .attributed(let attributedText): self.attributedText = attributedText
        }
    }
}
