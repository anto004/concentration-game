import UIKit

class ConcentrationViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2);

    var flipCount = 0{
        didSet {
            updateFlipCountLabel();
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel();
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let cardNumber = visibleCardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber);
            updateViewFromModel();
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.black,
            ]
        let attributedString = NSAttributedString(
            string: traitCollection.verticalSizeClass == .compact ? "Flips:\n \(flipCount)"
                :"Flips: \(flipCount)", attributes: attributes);
        flipCountLabel.attributedText = attributedString;
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        updateFlipCountLabel();
    }
    private func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1);
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        }
    }

    private func updateViewFromModel() {
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index];
                let card = game.cards[index];
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal);
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1);
                }
                else {
                    button.setTitle("", for: UIControlState.normal);
                    button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1);
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    private var visibleCardButtons: [UIButton]! {
        return cardButtons?.filter({ !$0.superview!.isHidden})
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        updateViewFromModel();
    }
   
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎";
    
    private var emojiDictionary = Dictionary<Card, String>();
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? "";
            emojiDictionary = [:]; // empty dictionary
            updateViewFromModel();
        }
    }

    //Since two cards have the same identifier
    //two cards will have the same emoji
    func emoji(for card: Card) -> String {
        if emojiDictionary[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex,
                                                 offsetBy: emojiChoices.count.arc4Random);
            emojiDictionary[card] = String(emojiChoices.remove(at: stringIndex));
        }
        return emojiDictionary[card] ?? "?"; //if not nill return that value else return "?"
    }
    
}



extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))); // self is the Int passed to this function
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)));
        }
        else {
            return 0;
        }
    }
}

