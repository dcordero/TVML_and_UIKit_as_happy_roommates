//
//  TVMLViewController.swift
//  Swift+TVML
//
//  Created by David Cordero on 09.06.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit
import TVMLKit

class TVMLViewController: UIViewController, TVApplicationControllerDelegate {
    
    private var containerView: UIView!
    
    var appController: TVApplicationController?

    override func viewDidLoad() {
        setUpTVMLAppController()
        setUpContainerView()
    }
    
    // MARK: - Private
    
    private func setUpContainerView() {
        guard let tvmlViewController = appController?.navigationController else { return }
        containerView = UIView()
        containerView.frame = view.bounds
        addChildViewController(tvmlViewController)
        view.addSubview(tvmlViewController.view)
    }
    
    // Create an instance of TVApplicationController, loading content
    // from a local file application.js included in the Application Bundle
    private func setUpTVMLAppController() {
        let appControllerContext = TVApplicationControllerContext()
        let appJS = Bundle.main.url(forResource: "application", withExtension: "js")
        
        if let javaScriptURL = appJS {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        
        // Here is the magic. Setting nil to the window creates a deatached the application controller
        appController = TVApplicationController(context: appControllerContext,
                                                window: nil,
                                                delegate: self)
    }
    
    // Dummy function to simulate an async swift interface
    private func giveMeTheName(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let array = ["Frodo", "Sam", "Legolas", "Bilbo"]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            
            completion(array[randomIndex])
        }
    }
    
    // MARK: - TVApplicationControllerDelegate
    
    // Indicate that the js application did launched
    func appController(_ appController: TVApplicationController, didFinishLaunching options: [String : Any]?) {
        print("appController::didFinishLaunching")
        
        // Get a random name asyncrously
        giveMeTheName {
            name in
            
            // Call the method updateName defined in application.js with $name as parameter
            appController.evaluate(
                inJavaScriptContext: {
                    jsContext in
                    
                    let updateNameMethod = jsContext.objectForKeyedSubscript("updateName")
                    updateNameMethod?.call(withArguments: [name])
            }, completion: nil)
        }
    }
    
    // Here we create the function binding
    func appController(_ appController: TVApplicationController, evaluateAppJavaScriptIn jsContext: JSContext) {
        
        // Defines a function to be called from js
        let showMyNameButtonWasPressed: @convention(block) (String) -> Void = {
            name in
            
            // The user did press the button 'ShowMyName' in the tvml screen
            let viewController = DetailViewController()
            viewController.detailTitle = name
            
            // Using the navigationController inside the tvml appController because it is the
            // actual viewcontroller in the screen
            self.appController?.navigationController.present(viewController, animated: true, completion: nil)
        }
        
        // Binding the previously declared funtion with the js
        jsContext.setObject(showMyNameButtonWasPressed,
                            forKeyedSubscript: "showMyNameButtonWasPressed" as NSCopying & NSObjectProtocol);
    }
}
