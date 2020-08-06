//
//  GameViewController.swift
//  InvasaoAlienigena
//
//  Created by Juliana Prado on 05/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import MultipeerConnectivity

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let session = MCSession(peer: MCPeerID(displayName: "Mary"))
        let serviceType = "io-objc-mpc" // Limited to 15 ASCII characters
        let browser = MCBrowserViewController(serviceType: serviceType, session: session)
        self.present(browser, animated: true, completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
