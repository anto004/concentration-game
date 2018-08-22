//
// Created by Antonio Bang on 8/18/18.
// Copyright (c) 2018 UCLAExtension. All rights reserved.
//

import Foundation

struct Concentration {

    //TODO: shuffle the cards
    private(set) var cards = Array<Card>();

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter{ cards[$0].isFaceUp};
            return faceUpCardIndices.oneAndOnly;
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

    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard: \(index): index out of bounds");
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards matched
                if cards[matchIndex] == cards[index] {
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
