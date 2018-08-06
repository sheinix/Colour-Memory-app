//
//  CMGame.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation
import UIKit

class Game {
    var boardMatrix : [[Card]] = [[]]
    var rounds : [GameRound] = []
    var lastRound : GameRound {
        return rounds.last!
    }
    var players : [Player]
    var winner : Player {
        return players.max(by: { (player1, player2) -> Bool in
            return player1.points > player2.points
        })!
    }
    var currentTurn : Player
    var cardList : [Card] = []
    var isFinished : Bool {
        return boardMatrix.flatMap({ $0 })
        .map({ !$0.isRemoved })
        .filter({ $0 })
        .count == 0
    }
    
    init(players: [Player] = [Player(1), Player(2)]) {
        self.players = players
        self.currentTurn = players.first!
    }
    
    public func setupBoard(gridSize : Int = 4) {
       
        generateCards(gridSize: gridSize)
        
        for rowIdx in 0..<gridSize {
            
            for _ in 0...gridSize-1 {
                
                if let newCard = cardList.popLast() {
                    boardMatrix[rowIdx].append(newCard)
                }
            }

            if rowIdx < gridSize-1 {
                boardMatrix.append([Card]())
            }
        }
    }
    
    fileprivate func generateCards(gridSize : Int) {
        let totalSize = gridSize * 2
        
        for idx in 1...totalSize * 2 {
            let number = idx > totalSize ? idx - totalSize : idx
            let imgName = "colour\(number)"
            let colourImage = UIImage(named: imgName)!
            let card = Card(image: colourImage, colourNumber: number)
            cardList.append(card)
        }
  
        cardList.shuffle()
    }
    
    public func reset() {
        boardMatrix = [[]]
        rounds.removeAll()
        players.removeAll()
        cardList.removeAll()
        players = [Player(1), Player(2)]
        currentTurn = players.first!
        setupBoard()
    }
    
    public func nextTurn() {
        if var idx = players.index(of: currentTurn) {
            idx = idx + 1 >= players.count ? 0 : idx + 1
            currentTurn = players[idx]
        } else {
            currentTurn = players.first!
        }
    }
}
