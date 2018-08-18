//
// Created by Antonio Bang on 8/18/18.
// Copyright (c) 2018 UCLAExtension. All rights reserved.
//

import Foundation

class Concentration {

    //TODO: shuffle the cards
    var cards = Array<Card>();

    var indexOfOneAndOnlyFaceUpCard: Int?

    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card();
            cards += [card, card] // two copy of cards with same identifier are appended, not pointing to the same card
        }
    }

    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true;
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true;
                indexOfOneAndOnlyFaceUpCard = nil;
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false;
                }
                cards[index].isFaceUp = true;
                indexOfOneAndOnlyFaceUpCard = index;
            }
        }
    }
}
