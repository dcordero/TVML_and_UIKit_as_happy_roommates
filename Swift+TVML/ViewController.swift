//
//  ViewController.swift
//  Swift+TVML
//
//  Created by David Cordero on 06.06.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit
import TVMLKit

class ViewController: UIViewController {
    
    var appController: TVApplicationController?

    @IBAction func sendMeToTVMLButtonWasPressed(_ sender: Any) {
        setUpTVMLAppController()
        
        if let navigationController = appController?.navigationController {
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private
    
    private func setUpTVMLAppController() {
        let appControllerContext = TVApplicationControllerContext()
        let appJS = Bundle.main.url(forResource: "application", withExtension: "js")
        
        if let javaScriptURL = appJS {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        
        appController = TVApplicationController(context: appControllerContext,
                                                window: nil,
                                                delegate: nil)
    }
}
