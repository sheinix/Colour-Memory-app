//
//  AppDelegate.swift
//  Colour Memory
//
//  Created by Juan Nuvreni on 4/08/18.
//  Copyright © 2018 sheinix. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.applicationCoordinator = ApplicationCoordinator(window: window)
        self.applicationCoordinator?.start()
        
        return true
    }
}
