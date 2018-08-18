import UIKit

class ViewController: UIViewController {

    var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
    
    var emojiChoices = ["🎃", "👻", "🙂", "😊"];
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender);
        }
        
    }

    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCount += 1;
        flipCard(withEmoji: "🎃", on: sender);
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1);
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal);
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        }
    }
    
    
    
    
}

