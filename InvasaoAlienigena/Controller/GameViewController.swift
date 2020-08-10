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

class GameViewController: UIViewController,MCSessionDelegate, MCBrowserViewControllerDelegate {

    var peerID = MCPeerID(displayName: UIDevice.current.name)
    var session: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    var messageToSend: String!
    let serviceType = "aliens-iegame"
    let kMCSessionMaximumNumberOfPeers = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        let h = dao
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        session = MCSession(peer: peerID)
        
        session?.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))

    }
    
    func startHosting(action: UIAlertAction) {
        guard let session = session else { return }
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: session)
        mcAdvertiserAssistant?.start()
    }

    func joinSession(action: UIAlertAction) {
        guard let session = session else { return }
        let browser = MCBrowserViewController(serviceType: serviceType, session: session)
        browser.delegate = self
        present(browser, animated: true, completion: nil)
    }
    
    @IBAction func connectPeers(_ sender: UIButton) {
        showConnectionPrompt()
    }
    
    @objc func showConnectionPrompt() {
        let ac = UIAlertController(title: "Bora acabar com aliens", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
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
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
         switch state {
           case .connected:
               print("Connected: \(peerID.displayName)")

           case .connecting:
               print("Connecting: \(peerID.displayName)")

           case .notConnected:
               print("Not Connected: \(peerID.displayName)")

           @unknown default:
               print("Unknown state received: \(peerID.displayName)")
           }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
      
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
         dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
         dismiss(animated: true)
    }
    

}
