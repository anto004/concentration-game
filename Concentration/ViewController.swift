import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2);

    var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber);
            updateViewFromModel();
        }
    }
    
    private func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1);
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        }
    }

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index];
            let card = game.cards[index];
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal);
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
            }
            else {
                button.setTitle("", for: UIControlState.normal);
                button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1);
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0) : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"];
    
    private var emojiDictionary = Dictionary<Int, String>()

    //Since two cards have the same identifier
    //two cards will have the same emoji
    func emoji(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiDictionary[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4Random);
        }
        
        return emojiDictionary[card.identifier] ?? "?"; //if not nill return that value else return "?"
    }
    
}

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))); // self is the Int passed to this function
        }
        else if self < 0 {
            return Int(arc4random_uniform(UInt32(self)));
        }
        else {
            return 0;
        }
    }
}

