//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/1/1.
//

import UIKit
import WWPrint
import WWTypewriterLabel

final class ViewController: UIViewController {

    @IBOutlet weak var typewriterLabel: WWTypewriterLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typewriterTest()
    }
    
    func typewriterTest() {
        
        let string = "A typewriter is a mechanical or electromechanical machine for typing characters. Typically, a typewriter has an array of keys, and each one causes a different single character to be produced on paper by striking an inked ribbon selectively against the paper with a type element. At the end of the nineteenth century, the term 'typewriter' was also applied to a person who used such a device."
        
        let formattedText = NSAttributedString(string: string, attributes: [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.blue
        ])
        
        typewriterLabel.start(fps: 60, stringType: .general(string), loopType: .once)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.typewriterLabel.start(fps: 30, stringType: .attributed(formattedText), loopType: .infinity)
        }
    }
}

