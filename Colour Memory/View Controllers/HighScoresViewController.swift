//
//  HighScoresViewController.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 6/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import UIKit

protocol HighScoresDelegateProtocol : class {
    func didPressBackButton(vc : HighScoresViewController)
}

class HighScoresViewController: UIViewController, MainViewControllerProtocol {

    var viewModel : HighScoresViewModel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var highScoresLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    weak var delegate : HighScoresDelegateProtocol?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        tableView.registerReusableCell(TopScoreTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self

    }

    @IBAction func didPressBackButton(_ sender: UIButton) {
        delegate?.didPressBackButton(vc: self)
    }
}

extension HighScoresViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell : TopScoreTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        
        let player = viewModel.topScores[indexPath.row]
        cell.rankLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = player.name
        cell.pointsLabel.text = String(player.points)
        
        return cell
    }
}
