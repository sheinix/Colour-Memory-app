//
//  CMMainViewController.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewControllerProtocol {
    
    associatedtype ViewModelType
    var viewModel : ViewModelType { get set }
}

extension MainViewControllerProtocol where Self: UIViewController {
    
    init(_associatedViewModel: ViewModelType) {
        self.init()
        self.viewModel = _associatedViewModel
    }
}
