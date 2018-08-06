//
//  EnterWinnerNameViewController.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 6/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import UIKit

protocol EnterNameProtocolDelegate : class {
    func didPressDoneButton(vc: EnterWinnerNameViewController)
}

class EnterWinnerNameViewController: UIViewController, MainViewControllerProtocol {
    
    var viewModel : HighScoresViewModel!
    @IBOutlet weak var inputTxtField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var validationLabel: UILabel!
    weak var delegate : EnterNameProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTxtField.delegate = self
        inputTxtField.layer.borderColor = UIColor.white.cgColor
        inputTxtField.placeholder = "Homer Simpson"
        inputTxtField.borderStyle = .none
        inputTxtField.tintColor = UIColor.darkGray
        doneButton.layer.cornerRadius = 9
        validationLabel.isHidden = true
    }
    
    fileprivate func validateName() {
        if let text = inputTxtField.text {
            validationLabel.isHidden = !text.isEmpty
            doneButton.isEnabled = !text.isEmpty
        }
    }
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        if let text = inputTxtField.text {
            viewModel.savePlayer(name: text) { [weak self] _ in
                let alert = UIAlertController(title: "Success", message:  "\(text) saved Succesfully as Top Scorer", preferredStyle: .alert)
                weak var weakSelf = self
                let action = UIAlertAction(title: "Ok", style: .default, handler: {_ in self?.delegate?.didPressDoneButton(vc: weakSelf!) })
                alert.addAction(action)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension EnterWinnerNameViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateName()
    }
}
