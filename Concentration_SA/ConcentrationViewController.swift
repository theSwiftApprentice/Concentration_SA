
import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("noe")
        }
    }
    
    func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    var theme: [String]? {
        didSet {
            emojiChoices = theme ?? [""]
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var emojiThemes = [
        ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎","🍫"],
        ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯"],
        ["👛","👜","💼","🎒","👝","🛍","💰","👑","👠","👒"],
        ["🌝","🌛","🌚","🌞","🌜","💫","☄️","⭐️","🌍","💥"],
        ["🐙","🦑","🦐","🦀","🐡","🐠","🐟","🐬","🐳","🦈"],
        ["☀️","🌤","⛅️","🌥","☁️","🌦","🌧","⛈","🌩","🌨"]
    ]
    
    private lazy var emojiChoices = chooseRandomTheme()
    
    private func chooseRandomTheme() -> [String]{
        let theme = emojiThemes[emojiThemes.count.arc4random]
        return theme
    }
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiChoices.count > 0{
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction private func newGameButtonPressed(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        //game.newSetOfCards(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = chooseRandomTheme()
        game.flipCount = 0
        updateViewFromModel()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
    
}
