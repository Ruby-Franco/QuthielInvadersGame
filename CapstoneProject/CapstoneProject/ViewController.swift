//
//  ViewController.swift
//  CapstoneProject
//
//  Created by GWC2 on 7/29/19.
//  Copyright © 2019 GWC2. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
   // var player: SKSpriteNode!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let playerTexture = SKTexture(imageNamed: "spaceship")
//        player = SKSpriteNode(texture: playerTexture)
//        player.zPosition = 10
//        player.Position = CGPoint(x: 0, y: frame.height*0.2)
//        player.setScale(0.7)
//        addChild(player)
//
//        let frame2 = SKTexture(imageNamed: "spaceLights")
//        let animation = SKAction.animate(with: [playerTexture, frame2], timePerFrame: 0.25)
//        let runForever = SKAction.repeatForever((animation))
//        player.run(runForever)
        
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        button.backgroundColor = UIColor.red
//        button.setTitle("PewPew", for: .normal)
//        button.addTarget(self, action:#selector(JustPCAction), for: UIControl.Event.touchUpInside)
//        self.view.addSubview(button)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        var node: SKNode?
        if let anchor = anchor as? Anchor {
            if let type = anchor.type {
                node = SKSpriteNode(imageNamed: type.rawValue)
                node?.name = type.rawValue
            }
        }
        return node
        
//        let alien = SKSpriteNode(imageNamed: "alien")
//        alien.name = "alien"
//        return alien
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
