//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Sergey Lobanov on 06.10.2021.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var emojiChoices = ["🎃", "👻", "😀", "💿", "🕹", "⚽️", "❤️", "🍏", "🐶"]
    var emoji = [Int: String]()  // Dictionary<Int, String>
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
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }

    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .systemOrange
            }
        }
        let areTheLastTwoCards = (game.cards.filter { $0.isFaceUp && $0.isMatched }.count) == 2 &&
                                 (game.cards.filter { !$0.isFaceUp && $0.isMatched }.count == cardButtons.count - 2)
        if areTheLastTwoCards {
            showWinAlert()
        }
    }

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }

        return emoji[card.identifier] ?? "?"
    }

    func showWinAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let alert = UIAlertController(title: "Congratulations!", message: "You are winner", preferredStyle: .alert)
            let action = UIAlertAction(title: "Play again", style: .default) { action in
                switch action.style {
                case .default:
                    self.flipCount = 0
                    self.game = Concentration(numberOfPairsOfCards: (self.cardButtons.count + 1) / 2)
                    self.updateViewFromModel()
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    print("v")
                }
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

