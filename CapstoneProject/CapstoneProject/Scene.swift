//
//  Scene.swift
//  CapstoneProject
//
//  Created by GWC2 on 7/29/19.
//  Copyright © 2019 GWC2. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
 var sayingsPosition = Int.random(in: 1...3)
 func renewingNumber(){
      sayingsPosition = Int.random(in: 1...3)
   }
    let gameSize = CGSize(width: 2, height: 2)
    
    var haveFuel = false
    var leaveAlien = false
// var randomNumber = 0

    let stereotype1 = SKLabelNode(text: "Women can't be doctors!!!")
    let stereotype2 = SKLabelNode(text:"Women can't open ketchup bottles!")
    let stereotype3 = SKLabelNode(text: "Women are weak!!!")
    let fact1 = SKLabelNode(text:"Athenahealth discovered that 60% of")
    let fact1pt2 = SKLabelNode(text: "physicians<35 are female while 40% are male.")
    let fact2 = SKLabelNode(text:"Actually, women can open ketchup bottles.")
    let fact3 = SKLabelNode(text:"Jennifer Thompson set the women's")
    let fact3pt2 = SKLabelNode(text:" bench press world record at 312 lbs.")
    let educateLabel = SKLabelNode(text: "Educate")
    let blastLabel = SKLabelNode(text: "Blast")
    let pointsLabel = SKLabelNode(text: "Points:")
    let numberOfPointsLabel = SKLabelNode(text: "0")
    let AlienLabel = SKLabelNode(text:"Alien:")
    let alienSpeechLabel = SKLabelNode(text: "")
    let healthLabel =  SKLabelNode(text:"Fuel:")
    let healthStatusLabel = SKLabelNode(text:"50")
    let congratsLabel = SKLabelNode(text: "Congratulations!")
    let gameOverLabel = SKLabelNode(text: "Game Over.")
    
    var healthStatus = 50 {
        didSet {
            self.healthStatusLabel.text = "\(healthStatus)"
        }
    }
    
    var pointsEarned = 0 {
        didSet {
            self.numberOfPointsLabel.text = "\(pointsEarned)"
        }
    }
    
    var sceneView: ARSKView {
        return view as! ARSKView
    }

    var isWorldSetUp = false
    var aim: SKSpriteNode!
    var blast: SKSpriteNode!
    var educate: SKSpriteNode!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (healthStatus >= 10) {
            blastAlien()
        }
        
        //detect user touching the labels to interact with the alien
        let touch = touches.first!
        if educateLabel.contains(touch.location(in: self)) && educateLabel.isHidden == false{
            educateLabel.isHidden = true
            blastLabel.isHidden = true
            if sayingsPosition == 1{
                fact1.isHidden = false
                fact1pt2.isHidden = false
            } else if sayingsPosition == 2{
                fact2.isHidden = false
            }else{
                fact3.isHidden = false
                fact3pt2.isHidden = false
            }
            pointsEarned += 25
            if pointsEarned >= 100 {
                congratsLabel.isHidden = false
                pointsLabel.isHidden = true
                numberOfPointsLabel.isHidden = true
                AlienLabel.isHidden = true
                alienSpeechLabel.isHidden = true
                healthLabel.isHidden = true
                healthStatusLabel.isHidden = true
                let delaySeconds = 2.41
                DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds){
                    self.restartGame()
                }
            }
            healthStatus -= 20
            if healthStatus <= 0 {
                healthStatus = 0
                gameOverLabel.isHidden = false
                pointsLabel.isHidden = true
                numberOfPointsLabel.isHidden = true
                AlienLabel.isHidden = true
                alienSpeechLabel.isHidden = true
                healthLabel.isHidden = true
                healthStatusLabel.isHidden = true
                let delaySeconds = 2.41
                DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds){
                    self.restartGame()
                }
            }
            let delaySeconds = 2.41
            DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds){
                self.begoneAlien()
            }
            
        }
        if blastLabel.contains(touch.location(in: self)) && blastLabel.isHidden == false{
            educateLabel.isHidden = true
            blastLabel.isHidden = true
            begoneAlien()
            pointsEarned += 15
            if pointsEarned >= 100 {
                congratsLabel.isHidden = false
                pointsLabel.isHidden = true
                numberOfPointsLabel.isHidden = true
                AlienLabel.isHidden = true
                alienSpeechLabel.isHidden = true
                healthLabel.isHidden = true
                healthStatusLabel.isHidden = true
                let delaySeconds = 2.41
                DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds){
                    self.restartGame()
                }
            }
            healthStatus -= 10
            if healthStatus <= 0 {
                healthStatus = 0
                gameOverLabel.isHidden = false
                pointsLabel.isHidden = true
                numberOfPointsLabel.isHidden = true
                AlienLabel.isHidden = true
                alienSpeechLabel.isHidden = true
                healthLabel.isHidden = true
                healthStatusLabel.isHidden = true
                let delaySeconds = 2.41
                DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds){
                    self.restartGame()
                }
                
            }
        }
        
        //        for touch: AnyObject in touches {
        //            if atPoint(touch.location(self)) == educateLabel {
        //                educateLabel.isHidden = true
        //            }
        //        }
    }
    
    func setUpWorld() {
        guard let currentFrame = sceneView.session.currentFrame,
            let scene = SKScene(fileNamed: "Level1") else {
                return
            }
            for node in scene.children {
                if let node = node as? SKSpriteNode {
                    var translation = matrix_identity_float4x4
                    let positionX = node.position.x/scene.size.width
                    let positionY = node.position.y/scene.size.height
                    translation.columns.3.x = Float(positionX*gameSize.width)
                    translation.columns.3.z = -Float(positionY*gameSize.height)
                    translation.columns.3.y = Float.random(in: -0.5..<0.5)
                    let transform = simd_mul(currentFrame.camera.transform, translation)
                    let anchor = Anchor(transform: transform)
                    if let name = node.name,
                        let type = NodeType(rawValue: name){
                        anchor.type = type
                        sceneView.session.add(anchor: anchor)
                    }
                }
                isWorldSetUp = true
            }
 
//            if let name = node.name,
//                let type = NodeType(rawValue: name) {
//                    anchor.type = type
//                    sceneView.session.add(anchor: anchor)
//                }       
//            let anchor = ARAnchor(transform: transform)
        //sceneView.session.add(anchor: anchor)
        }

    func adjustLighting() {
        guard let currentFrame = sceneView.session.currentFrame, let lightEstimate = currentFrame.lightEstimate
            else {
                return
        }
        let neutralIntensity: CGFloat = 1000
        let ambientIntensity = min(lightEstimate.ambientIntensity, neutralIntensity)
        let blendFactor = 1 - ambientIntensity / neutralIntensity
        for node in children {
            if let alien = node as? SKSpriteNode {
                alien.color = .black
                alien.colorBlendFactor = blendFactor
            }
        }
    }
    
    func setUpLabel() {
        educateLabel.fontSize = 35
        educateLabel.fontName = "Courier"
        educateLabel.color = .green
        educateLabel.position = CGPoint(x: -70, y: -200)
        addChild(educateLabel)
        educateLabel.isHidden = true
        
        blastLabel.fontSize = 35
        blastLabel.fontName = "Courier"
        blastLabel.color = .red
        blastLabel.position = CGPoint(x: 100, y: -200)
        addChild(blastLabel)
        blastLabel.isHidden = true
        
        pointsLabel.fontSize = 20
        pointsLabel.fontName = "Courier"
        pointsLabel.color = .white
        pointsLabel.position = CGPoint(x: 90, y: 280)
        addChild(pointsLabel)
        
        numberOfPointsLabel.fontSize = 20
        numberOfPointsLabel.fontName = "Courier"
        numberOfPointsLabel.color = .white
        numberOfPointsLabel.position = CGPoint(x: 150, y: 280)
        addChild(numberOfPointsLabel)
        
        healthLabel.fontSize = 20
        healthLabel.fontName = "Courier"
        healthLabel.color = .white
        healthLabel.position = CGPoint(x:-100,y:280)
        addChild(healthLabel)
        
        healthStatusLabel.fontSize = 20
        healthStatusLabel.fontName = "Courier"
        healthStatusLabel.color = .white
        healthStatusLabel.position = CGPoint(x:-40, y:280)
        addChild(healthStatusLabel)
        
        AlienLabel.fontSize = 20
        AlienLabel.fontName = "Courier"
        AlienLabel.color = .white
        AlienLabel.position = CGPoint(x: 0, y: 260)
        addChild(AlienLabel)
        AlienLabel.isHidden = true
        
        alienSpeechLabel.fontSize = 20
        alienSpeechLabel.fontName = "Courier"
        alienSpeechLabel.color = .white
        alienSpeechLabel.position = CGPoint(x:0, y: 240)
        addChild(alienSpeechLabel)
        alienSpeechLabel.isHidden = true
        
        stereotype1.fontSize = 23
        stereotype1.fontName = "Courier"
        stereotype1.colorBlendFactor = 1
        stereotype1.color = UIColor.red
        stereotype1.position = CGPoint(x:0, y: 220)
        addChild(stereotype1)
        stereotype1.isHidden = true
        
        stereotype2.fontSize = 18.5
        stereotype2.fontName = "Courier"
        stereotype2.colorBlendFactor = 1
        stereotype2.color = UIColor.red
        stereotype2.position = CGPoint(x:0, y: 220)
        addChild(stereotype2)
        stereotype2.isHidden = true
        
        stereotype3.fontSize = 23
        stereotype3.fontName = "Courier"
        stereotype3.colorBlendFactor = 1
        stereotype3.color = UIColor.red
        stereotype3.position = CGPoint(x:0, y: 220)
        addChild(stereotype3)
        stereotype3.isHidden = true
        
        fact1.fontSize = 13.9
        fact1.fontName = "Courier"
        fact1.color = .white
        fact1.position = CGPoint(x:0, y: -150)
        addChild(fact1)
        fact1.isHidden = true
        
        fact1pt2.fontSize = 13.42
        fact1pt2.fontName = "Courier"
        fact1pt2.color = .white
        fact1pt2.position = CGPoint(x:0, y: -170)
        addChild(fact1pt2)
        fact1pt2.isHidden = true
        
        fact2.fontSize = 14.5
        fact2.fontName = "Courier"
        fact2.color = .white
        fact2.position = CGPoint(x:0, y: -150)
        addChild(fact2)
        fact2.isHidden = true
        
        fact3.fontSize = 17
        fact3.fontName = "Courier"
        fact3.color = .white
        fact3.position = CGPoint(x:0, y: -150)
        addChild(fact3)
        fact3.isHidden = true
        
        fact3pt2.fontSize = 17
        fact3pt2.fontName = "Courier"
        fact3pt2.color = .white
        fact3pt2.position = CGPoint(x:0, y: -170)
        addChild(fact3pt2)
        fact3pt2.isHidden = true
        
        congratsLabel.fontSize = 35
        congratsLabel.fontName = "Courier"
        congratsLabel.color = .green
        congratsLabel.position = CGPoint(x: 0, y: 00)
        addChild(congratsLabel)
        congratsLabel.isHidden = true
        
        gameOverLabel.fontSize = 50
        gameOverLabel.fontName = "Courier"
        gameOverLabel.color = .red
        gameOverLabel.position = CGPoint(x: 0, y: 00)
        addChild(gameOverLabel)
        gameOverLabel.isHidden = true
    }
    
 //   let labelA = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//    labelA.position = CGPoint(x: 160, y: 285)
//    labelA.textAlignment = .center
//    labelA.text = "I'm a test label"
//    self.view.addSubview(labelA)
    
    func begoneAlien () {
        stereotype1.isHidden = true
        stereotype2.isHidden = true
        stereotype3.isHidden = true
        
        fact1.isHidden = true
        fact1pt2.isHidden = true
        fact2.isHidden = true
        fact3.isHidden = true
        fact3pt2.isHidden = true

        leaveAlien = true
        blastAlien()
    }
    
    func blastAlien(){
        let location = aim.position
        let hitNodes = nodes(at: location)
        var encounteredAlien: SKNode?
        for node in hitNodes{
            if node.name == "alien" {
                encounteredAlien = node
                break
            }
        }
        if let encounteredAlien = encounteredAlien { //the following code runs when user hits alien with aim circle thing
            if leaveAlien == false{
                educateLabel.isHidden = false
                blastLabel.isHidden = false
                AlienLabel.isHidden = false
                alienSpeechLabel.isHidden = false
    
                if sayingsPosition == 1{
                    stereotype1.isHidden = false
                } else if sayingsPosition == 2{
                    stereotype2.isHidden = false
                }else{
                    stereotype3.isHidden = false
                }
            }
            if leaveAlien == true{
                let removeAlien = SKAction.removeFromParent()
                let sequence = SKAction.sequence([removeAlien])
                encounteredAlien.run(sequence)
                AlienLabel.isHidden = true
                leaveAlien = false
                renewingNumber()
            }
            
        }
    }
    
    func collectFuel(currentFrame: ARFrame) {
        for anchor in currentFrame.anchors {
            guard let node = sceneView.node(for: anchor),
            node.name == NodeType.fuel.rawValue
                else{continue}
            let distance = simd_distance(anchor.transform.columns.3, currentFrame.camera.transform.columns.3)
            if distance < 0.1 {
                sceneView.session.remove(anchor: anchor)
                haveFuel = true
                healthStatus = healthStatus + 20
                if healthStatus >= 100 {
                    healthStatus = 100
                }
                
                break
            }
        }
    }
    func restartGame(){
        pointsEarned = 0
        healthStatus = 50
        pointsLabel.isHidden = false
        numberOfPointsLabel.isHidden = false
        AlienLabel.isHidden = false
        alienSpeechLabel.isHidden = false
        healthLabel.isHidden = false
        healthStatusLabel.isHidden = false
        gameOverLabel.isHidden = true
        congratsLabel.isHidden = true
        setUpWorld()
        
    }
    
    
    override func didMove(to view: SKView) {
//        if let musicURL = Bundle.main.url(forResource: "AlienBackgroundMusic", withExtension: "mp3"){
//            backgroundMusic = SKAudioNode(url: musicURL)
//            addChild(backgroundMusic)
//        } else {
//            print("nope")
//        }
        aim = SKSpriteNode(imageNamed: "aim")
        addChild(aim)
        setUpLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isWorldSetUp == false {
            setUpWorld()
        }
        adjustLighting()
        guard let currentFrame = sceneView.session.currentFrame else {
            return
        }
        collectFuel(currentFrame: currentFrame)
    }
}
