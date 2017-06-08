//
//  DetailViewController.swift
//  Swift+TVML
//
//  Created by David Cordero on 08.06.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailTitle: String?
    
    private var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Private
    
    private func setUpView() {
        titleLabel = UILabel()
        titleLabel.text = detailTitle
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

