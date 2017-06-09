//
//  InitialViewController.swift
//  Swift+TVML
//
//  Created by David Cordero on 06.06.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
        
    @IBAction func sendMeToTVMLButtonWasPressed(_ sender: Any) {
        
        let tvmlViewController = TVMLViewController()
        present(tvmlViewController, animated: true, completion: nil)
    }
}
