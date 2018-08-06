//
//  HighScoresViewModel.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 6/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation

struct HighScoresViewModel {
    
    var topScores : [Player]
    let currentWinner : Player?
    static let tableLimit : Int = 10

    init(winner : Player? = nil) {
        topScores = HighScoresViewModel.getTopScores() ?? []
        currentWinner = winner
    }
    
    public func savePlayer(name: String, completion: @escaping (_ : Bool) -> ()) {
        guard let winner = currentWinner else {
            completion(false)
            return
        }
       
        winner.name = name
        var scores = HighScoresViewModel.getTopScores() ?? []
        scores.append(winner)
        HighScoresViewModel.save(topScores: scores)
        completion(true)
    }
    
    fileprivate static func getTopScores() -> [Player]? {
        
        if let topScoresData = UserDefaults.standard.value(forKey: "topScores") as? Data {
            let decoder = JSONDecoder()
            if let scores = try? decoder.decode([Player].self, from: topScoresData) {
                return scores.sorted(by: { (p1, p2) -> Bool in
                    return p1.points > p2.points
                })
            }
        }
        return nil
    }
    
    fileprivate static func save(topScores : [Player]) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(topScores) {
            UserDefaults.standard.set(encoded, forKey: "topScores")
        }
    }
    
    public static func shouldSaveScoreFor(player: Player) -> Bool {
        
        var scores = HighScoresViewModel.getTopScores() ?? []
        
        if scores.count <= tableLimit { return true }
        
        guard let minPlayer = scores.min(by: {(player1, player2) -> Bool in
            player1.points < player2.points
        }) else { return false }
        
        let shouldSaveScore =  minPlayer.points < player.points
        
        if shouldSaveScore {
            
            if let idx = scores.index(of: minPlayer) {
                scores.remove(at: idx)
                HighScoresViewModel.save(topScores: scores)
            }
        }
        
        
        return shouldSaveScore
    }
}
