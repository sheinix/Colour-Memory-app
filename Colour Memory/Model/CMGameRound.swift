//
//  CMGameRound.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation

class GameRound {
    var cardsNeededToMatch : Int = 2
    var player : Player
    var cardsFliped : [Card] = []
    var indexPaths : [IndexPath] {
        return cardsFliped.map({ $0.currentIdxPath ?? [] })
    }
    var isFinished : Bool {
        return cardsFliped.count == cardsNeededToMatch
    }
    var isAMatch : Bool {
        let set = Set(cardsFliped) //unique elements
        return set.count == 1
    }
    
    init(cardsNeededToMatch : Int = 2, player: Player) {
        self.cardsNeededToMatch = cardsNeededToMatch
        self.player = player
    }
}
