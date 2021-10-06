//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Sergey Lobanov on 06.10.2021.
//

import UIKit

class ViewController: UIViewController {
    var emojiChoices = ["👻", "🎃", "👻", "🎃"]
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!  // Array<UIButton>!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("flip card \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = .systemOrange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }


}

