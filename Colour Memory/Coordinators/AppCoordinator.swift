//
//  AppCoordinator.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    var rootViewController: UIViewController!
    
    init(window: UIWindow) {
        self.window = window
        let gameVM = GameViewModel()
        let gameVC = GameBoardViewController(_associatedViewModel: gameVM)
        gameVC.delegate = self
        rootViewController = gameVC
        
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}


extension ApplicationCoordinator : GameBoardDelegateProtocol {
    func didTapOnTopScoresButton() {
        let highScoresVM = HighScoresViewModel()
        let highScoresVC = HighScoresViewController(_associatedViewModel: highScoresVM)
        highScoresVC.delegate = self
        rootViewController.modalTransitionStyle = .coverVertical
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.present(highScoresVC, animated: true, completion: nil)
    }
    
    func gameDidEndWithWinner(player: Player) {
        
        if HighScoresViewModel.shouldSaveScoreFor(player: player) {
            let highScoresVM = HighScoresViewModel(winner: player)
            let enterWinnerVC = EnterWinnerNameViewController(_associatedViewModel: highScoresVM)
            enterWinnerVC.delegate = self
            rootViewController.present(enterWinnerVC, animated: true, completion: nil)
        }
        
    }
}

extension ApplicationCoordinator : HighScoresDelegateProtocol {
    func didPressBackButton(vc: HighScoresViewController) {
        vc.dismiss(animated: true, completion: nil)
    }
}

extension ApplicationCoordinator : EnterNameProtocolDelegate {
    func didPressDoneButton(vc: EnterWinnerNameViewController) {
        if let gameVC = rootViewController as? GameBoardViewController {
            gameVC.viewModel.resetGame()
            gameVC.viewModel.startGame()
            gameVC.cardsCollectionView.reloadData()
            vc.dismiss(animated: true, completion: nil)
        }
        
    }
}
