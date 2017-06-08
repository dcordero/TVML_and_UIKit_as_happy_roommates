//
//  ViewController.swift
//  Swift+TVML
//
//  Created by David Cordero on 06.06.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import UIKit
import TVMLKit

class ViewController: UIViewController, TVApplicationControllerDelegate {
    
    var appController: TVApplicationController?

    @IBAction func sendMeToTVMLButtonWasPressed(_ sender: Any) {
        
        setUpTVMLAppController()
        
        if let navigationController = appController?.navigationController {
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    // MARK: - TVApplicationControllerDelegate
    
    func appController(_ appController: TVApplicationController, didFinishLaunching options: [String : Any]?) {
        print("appController::didFinishLaunching")

    }
    
    func appController(_ appController: TVApplicationController, evaluateAppJavaScriptIn jsContext: JSContext) {
        
        let giveMeNameNative: @convention(block) () -> String = {
            let sem = DispatchSemaphore.init(value: 0);
            var name = "";
            self.giveMeTheName(completion: { (nativeName) in
                name = nativeName;
                sem.signal()
            });
            sem.wait();
            
            return name;
        }
        
        jsContext.setObject(giveMeNameNative, forKeyedSubscript: "giveMeName" as NSCopying & NSObjectProtocol);
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
                                                delegate: self)
    }
    
    private func giveMeTheName(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let array = ["Frodo", "Sam", "Legolas", "Bilbo"]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            
            completion(array[randomIndex])
        }
    }
}
