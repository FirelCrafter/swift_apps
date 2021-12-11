//
//  GameScene.swift
//  JumperGame
//
//  Created by Михаил Щербаков on 02.11.2021.
//

import Foundation
import SpriteKit
import SwiftUI
import GameplayKit
import AVFoundation

struct ColliderTtype {
    
    static let player: UInt32 = 1
    static let stair: UInt32 = 2
    static let stairTop: UInt32 = 3
}




class GameScene: SKScene, ObservableObject, SKPhysicsContactDelegate {
    
    // Stairs variables
    var stairTimer = Timer()
    var stairDetected = true
    var gameOver = false
    var stairsCounter: Int32 = 0
    var firstStairY = UIScreen.main.bounds.height / 8
    var stairSpeed: CGFloat = 60
    var speedTimer = Timer()
    
    // Movement
    var tap = UITapGestureRecognizer()
    var swipe = UISwipeGestureRecognizer()
    var swiped = false
    var touchesBegan = false
    
    
    
    let player = SKSpriteNode(imageNamed: "monster1")
    var audioPlayer: AVAudioPlayer?
    
    let jumpSound = SKAction.playSoundFileNamed("jump.m4a", waitForCompletion: false)
    let gameOverSound = SKAction.playSoundFileNamed("gameOver.m4a", waitForCompletion: false)
    
    override init(size: CGSize) {
            super.init(size: size)
            print("Scene init")
        }

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            print("Scene init")
        }
    
    override func didMove(to view: SKView) {
        
        // Player
        
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene?.scaleMode = .fill
        
        anchorPoint = .zero
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        self.physicsWorld.contactDelegate = self
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        
        
        
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = ColliderTtype.player
        player.physicsBody?.collisionBitMask = ColliderTtype.stair
        player.physicsBody?.contactTestBitMask = ColliderTtype.stair
        player.physicsBody?.collisionBitMask = ColliderTtype.stairTop
        player.physicsBody?.contactTestBitMask = ColliderTtype.stairTop
        player.name = "player"
        
        //Player position
        
        player.position = CGPoint(x: UIScreen.main.bounds.width / 2 - player.size.width / 2,
                                  y: UIScreen.main.bounds.height / 2 - player.size.height / 2)
        
        player.setScale(0.4)
        player.zPosition = 10
        addChild(player)
        
        moveBackground(image: "GameBackground", y: 5, z: -5, duration: 5, needPhysics: false, size: self.size)
        
        // Stairs spawn
        
        spawnStairs(x: 0, y: firstStairY, duration: getDurarion(x1: 0, y1: firstStairY, x2: -100, y2: -20, speed: 80))
        spawnStairs(x: 60, y: firstStairY + 45, duration: getDurarion(x1: 60, y1: firstStairY + 45, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 120, y: firstStairY + 90, duration: getDurarion(x1: 120, y1: firstStairY + 90, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 180, y: firstStairY + 135, duration: getDurarion(x1: 180, y1: firstStairY + 135, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 240, y: firstStairY + 180, duration: getDurarion(x1: 240, y1: firstStairY + 180, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 300, y: firstStairY + 225, duration: getDurarion(x1: 300, y1: firstStairY + 225, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 360, y: firstStairY + 270, duration: getDurarion(x1: 360, y1: firstStairY + 270, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 420, y: firstStairY + 315, duration: getDurarion(x1: 420, y1: firstStairY + 315, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnStairs(x: 480, y: firstStairY + 360, duration: getDurarion(x1: 480, y1: firstStairY + 360, x2: -100, y2: -20, speed: self.stairSpeed))
        spawnNewStair()
        
        speedTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(increaseSpeed), userInfo: nil, repeats: true)
        
        
    }
    
    // Movement functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if self.stairDetected {
                self.touchesBegan = true
                self.stairDetected = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
                    self.touchesBegan = false
                }
            }
        }
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        
        if stairDetected {
            self.stairDetected = false
            player.run(jumpSound)
            player.physicsBody?.velocity = CGVector(dx: 100, dy: 280)
            self.swiped = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.run(jumpSound)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.location(in: self)
        if (scene?.contains(location))! {
            print("swipe")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if touchesBegan {
            player.physicsBody?.velocity = CGVector(dx: 15, dy: 200)
        }
        
        if player.position.x > UIScreen.main.bounds.width - player.size.width / 2 {
            player.position.x = UIScreen.main.bounds.width - player.size.width / 2
        }
        
        if player.position.y < player.size.height / 2 || player.position.x < player.size.width / 2 {
            player.run(gameOverSound)
            self.gameOver = true
            self.resetScene()
            let newScene = GameOverScene()
            newScene.scaleMode = self.scaleMode
            newScene.backgroundColor = UIColor(Color("Background"))
            self.view?.presentScene(newScene, transition: SKTransition.fade(with: UIColor.black, duration: 1.5))
        }
        
        
    }
    
    
    // Collisions manager

    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "player" {
            
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "player" && secondBody.node?.name == "stair" {
            stairDetected = true
        }
        
        if firstBody.node?.name == "player" && secondBody.node?.name == "stair1" {
            stairDetected = true
            self.stairsCounter += 1
            print("Score: \(stairsCounter)")
            secondBody.node?.removeFromParent()
        }
    }
    
    
    // Background
    
    func moveBackground(image: String, y: CGFloat, z: CGFloat, duration: Double, needPhysics: Bool, size: CGSize) {
        
        for i in 0...1 {
            
            let node = SKSpriteNode(imageNamed: image)
            
            node.anchorPoint = .zero
            node.position = CGPoint(x: size.width * CGFloat(i), y: y)
            node.size = size
            node.zPosition = z
            
            if needPhysics {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody?.isDynamic = false
                node.physicsBody?.contactTestBitMask = 1
                node.name = "node"
            }
            
            let move = SKAction.moveBy(x: -node.size.width, y: 0, duration: duration)
            let wrap = SKAction.moveBy(x: node.size.width, y: 0, duration: 0)
            let sequence = SKAction.sequence([move, wrap])
            let immer = SKAction.repeatForever(sequence)
            
            node.run(immer)
            
            addChild(node)
            
        }
        
    }
    
    // Stairs spawner
    
    func spawnNewStair() {
        
        let wait1: SKAction = SKAction.wait(forDuration: self.getDurarion(x1: 480, y1: self.firstStairY + 360, x2: 585, y2: self.firstStairY + 360 + 77, speed: self.stairSpeed + 48))
        
        let wait2: SKAction = SKAction.wait(forDuration: self.getDurarion(x1: 480, y1: self.firstStairY + 360, x2: 690, y2: self.firstStairY + 360 + 152, speed: self.stairSpeed + 48))
        
        
        let spawn = SKAction.run {
            self.spawnStairs(x: 480, y: self.firstStairY + 360, duration: self.getDurarion(x1: 480, y1: self.firstStairY + 360, x2: -100, y2: -20, speed: self.stairSpeed))
        }
        
        let actionsList = [SKAction.group([wait1, spawn]), SKAction.group([wait2, spawn]), SKAction.group([wait1, spawn]), SKAction.group([wait1, spawn])]
        
        var sequence: SKAction {
            var actions: [SKAction] = []
            for _ in 1...100 {
                actions.append(actionsList.randomElement()!)
            }
            return SKAction.sequence(actions)
        }
        
        self.run(SKAction.repeatForever(sequence))

    }
    
    
    func spawnStairs(x: CGFloat, y: CGFloat, duration: CGFloat) {
        
        let stair = SKSpriteNode(imageNamed: "Stair")
        stair.position = CGPoint(x: x, y: y)
        stair.setScale(1)
        stair.zPosition = 5
        stair.physicsBody = SKPhysicsBody(rectangleOf: stair.size)
        stair.physicsBody?.isDynamic = false
        stair.physicsBody?.contactTestBitMask = ColliderTtype.stair
        stair.name = "stair"
        
        addChild(stair)
        
        let stair1 = SKSpriteNode(color: UIColor.clear, size: CGSize(width: stair.size.width - 6, height: stair.size.height))
        stair1.position = CGPoint(x: x, y: y + 3)
        stair1.setScale(1)
        stair1.zPosition = 5
        stair1.physicsBody = SKPhysicsBody(rectangleOf: stair1.size)
        stair1.physicsBody?.isDynamic = false
        stair1.physicsBody?.contactTestBitMask = ColliderTtype.stairTop
        stair1.name = "stair1"
        
        addChild(stair1)
        
        let stairMove = SKAction.move(to: CGPoint(x: -100, y: -20), duration: duration)
        let removeAction = SKAction.removeFromParent()
        
        let actions = SKAction.sequence([stairMove, removeAction])
        
        stair.run(actions)
        stair1.run(actions)
        
    }
    
    @objc func spawnStair() {
        spawnStairs(x: 480, y: firstStairY + 360, duration: 18)
    }
    
    func getDurarion(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, speed: CGFloat) -> TimeInterval {
        
        let pointA = CGPoint(x: x1, y: y1)
        let pointB = CGPoint(x: x2, y: y2)
        
        let xDist = (pointB.x - pointA.x)
        let yDist = (pointB.y - pointA.y)
        
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        
        let duration: TimeInterval = TimeInterval(distance / speed)
        
        return duration
        
    }
    
    @objc func increaseSpeed() {
        
        return self.stairSpeed += 0.1
        
    }
    
    // Sounds
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Couldn't find sound file")
            }
        }
    }
    
    func resetScene() {
        self.removeAllActions()
        self.removeAllChildren()
    }
    
    deinit {
            print("Scene deinit")
        }
    
}
