//
// Created by Antonio Bang on 8/18/18.
// Copyright (c) 2018 UCLAExtension. All rights reserved.
//

import Foundation

class Concentration {

    //TODO: shuffle the cards
    private(set) var cards = Array<Card>();

    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index;
                    }
                    else {
                        return nil; //set face up cards
                    }
                }
            }
            return foundIndex;
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue) //new Value returned from foundIndex
            }
        }
    }

    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card();
            cards += [card, card] // two copy of cards with same identifier are appended, not pointing to the same card
        }
    }

    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard: \(index): index out of bounds");
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true;
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true;
                
            }
            else {
                indexOfOneAndOnlyFaceUpCard = index;
            }
        }
    }
}
