//
//  BreakUpViewController.swift
//  BreakUp
//
//  Created by Apple on 9/10/15.
//  Copyright (c) 2015 Randall Lee. All rights reserved.
//

import UIKit

class BreakUpViewController: UINavigationController {

    override func viewDidLoad()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("showAuthenticationViewController"), name: PresentAuthenticationViewController, object: nil)
        
        GameKitHelper.sharedInstance.authenticateLocalPlayer()
        super.viewDidLoad()
    }
    
    func showAuthenticationViewController()
    {
        let gameKitHelper = GameKitHelper.sharedInstance
        if let authenticationViewController = gameKitHelper.authenticationViewController
    {
        topViewController.presentViewController(authenticationViewController, animated: true,
        completion: nil)
        }
    }
    deinit { NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
