//
//  GameViewModel.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation
import UIKit

class GameViewModel {
    
    var game : Game
    var gameFinishedWith : ((_: Player) -> Void)?
    var currentTurn : ((_: Player) -> Void)?
    var roundFinished : ((_: [IndexPath]) -> Void)?
    
    init() {
        let game = Game(players: [Player(1), Player(2)])
        self.game = game
        self.game.setupBoard()
    }
    
    public func numberOfItems() -> Int {
        let rowCount = game.boardMatrix.count
        return rowCount * rowCount
    }
    
    public func cardFor(idxPath: IndexPath) -> Card? {
        
        guard let columns = game.boardMatrix.first?.count else { return nil }
        let item = CGFloat(idxPath.item)
        let row = floor(item / CGFloat(columns))
        let column = item.truncatingRemainder(dividingBy: CGFloat(columns))
        
        return game.boardMatrix[Int(row)][Int(column)]
    }
    
    public func startGame() {
        let firstRound = GameRound(player: game.currentTurn)
        self.game.rounds.append(firstRound)
    }
    
    public func resetGame() {
        self.game.reset()
        if let turn = currentTurn {
            turn(game.currentTurn)
        }
    }
    
    public func playerFliped(card: Card, at idxPath: IndexPath) {
       
        guard let currentRound = game.rounds.last else { return }
        card.currentIdxPath = idxPath
        currentRound.cardsFliped.append(card)
        guard currentRound.isFinished else { return }
        manageTurn(currentRound: currentRound)
        if let roundFinish = roundFinished {
            roundFinish(currentRound.indexPaths)
        }
        if !game.isFinished {
            game.rounds.append(GameRound(player: game.currentTurn))
        } else {
            if let winnerBlock = gameFinishedWith {
                winnerBlock(game.winner)
            }
        }
    }
    
    fileprivate func manageTurn(currentRound: GameRound) {
        
        let points = currentRound.isAMatch ? 2 : -1
        game.currentTurn.points = game.currentTurn.points + points
        game.nextTurn()
        if let turn = currentTurn {
            turn(game.currentTurn)
        }
        currentRound.cardsFliped.forEach({ (card) in
            card.isRemoved = currentRound.isAMatch
            card.isFlippedUp = currentRound.isAMatch
        })
    }
}
