//
// Created by Antonio Bang on 8/18/18.
// Copyright (c) 2018 UCLAExtension. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false;
    var isMatched = false;
    var identifier: Int;

    init(){
        self.identifier = Card.getUniqueIdentifier();
    }
    
    private static var identifierFactory = 0;

    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1;
        return identifierFactory ;
    }
}
