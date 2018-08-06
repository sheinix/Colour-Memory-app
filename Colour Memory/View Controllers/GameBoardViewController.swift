//
//  GameBoardViewController.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import UIKit

let minimumSpacing : CGFloat = CGFloat(integerLiteral: 1)

protocol GameBoardDelegateProtocol : class {
    func didTapOnTopScoresButton()
    func gameDidEndWithWinner(player: Player)
}

class GameBoardViewController: UIViewController, MainViewControllerProtocol {
   
    var viewModel : GameViewModel!
    weak var delegate : GameBoardDelegateProtocol?
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var topScoresButton: UIButton!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.registerReusableCell(CardCollectionViewCell.self)
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        setupGame()
    }
    
    fileprivate func setupGame() {
        viewModel.gameFinishedWith = { [weak self] winner in
            
           self?.showWinnerAlert(winner: winner)
        }
        
        viewModel.currentTurn = { [weak self] currentPlayer in
            if let playerName = currentPlayer.name {
                self?.currentScoreLabel.text = "Current Score: \n \(playerName) : \(String(currentPlayer.points))"
            }
        }
        
        viewModel.roundFinished = { [weak self] roundIndexes in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.cardsCollectionView.reloadItems(at: roundIndexes)
            }
        }
        
        viewModel.startGame()
    }
    
    
    @IBAction func didPressTopScoresButton(_ sender: Any) {
        delegate?.didTapOnTopScoresButton()
    }
    
    fileprivate func showWinnerAlert(winner: Player) {
        
        let alert = UIAlertController(title: "Congratulations!", message: "\(winner.name!) has won the game", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.delegate?.gameDidEndWithWinner(player: winner)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource Methods

extension GameBoardViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CardCollectionViewCell = collectionView.dequeueReusableCellOfCollection(indexPath: indexPath)
        if let card = viewModel.cardFor(idxPath: indexPath) {
            cell.setCardImgViewWith(card: card)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell : CardCollectionViewCell = collectionView.dequeueReusableCellOfCollection(indexPath: indexPath)
        if let card = viewModel.cardFor(idxPath: indexPath) {
            guard !card.isFlippedUp else { return }
            cell.flipUp(card: card)
            collectionView.reloadItems(at: [indexPath])
            viewModel.playerFliped(card: card, at: indexPath)
        }
    }
}

extension GameBoardViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCount = CGFloat(integerLiteral: viewModel.game.boardMatrix.count)
        let width = self.view.bounds.width/itemsCount
        let heightDiff = self.view.bounds.height - collectionView.bounds.height
        let height = ((self.view.bounds.height - heightDiff)/itemsCount)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
