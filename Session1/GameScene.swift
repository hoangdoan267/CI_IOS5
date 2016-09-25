//
//  GameScene.swift
//  Session1
//
//  Created by Hoang Doan on 8/28/16.
//  Copyright (c) 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Nodes
//    var plane:SKSpriteNode!
    
    //
    var lastUpdateTime : NSTimeInterval = -1
    
    // Counters
    var bulletIntervalCount = 0
    var enemyIntervalCount = 0
    var playerPlaneController : PlayerPlaneController!
    var enemyPlaneController : EnemyPlaneController!
    
    
    
    override func didMoveToView(view: SKView) {
        configurePhysics()
        addBackground()
        addPlane()
        addEnemy(4)
        addPowerUp(8)
    }
    
    func configurePhysics() {
        //1
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0);
        self.physicsWorld.contactDelegate = self
        
        
    }    
  
    func didBeginContact(contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let nodeA = bodyA.node
        let nodeB = bodyB.node
        
        let maskA = bodyA.categoryBitMask
        let maskB = bodyB.categoryBitMask
        
        if ((maskA | maskB) == (PHYSICS_MASK_ENEMY | PHYSICS_MASK_PLAYER)) || ((maskA | maskB) == (PHYSICS_MASK_ENEMY | PHYSICS_MASK_PLAYER_BULLET)) || ((maskA | maskB) == (PHYSICS_MASK_PLAYER | PHYSICS_MASK_ENEMY_BULLET)){
            
            if let emitter = SKEmitterNode(fileNamed: "explosion.sks") {
                emitter.position = (bodyB.node?.position)!
                self.runAction(SKAction.sequence([
                    SKAction.runBlock { self.addChild(emitter) },
                    SKAction.waitForDuration(0.5),
                    SKAction.runBlock { emitter.removeFromParent()}
                    
                    ]))
                
                
            }
            nodeA?.removeFromParent()
            nodeB?.removeFromParent()

        } else if (maskA | maskB) == (PHYSICS_MASK_PLAYER | PHYSICS_MASK_POWERUP) {
            if maskA == PHYSICS_MASK_POWERUP {
                nodeA?.removeFromParent()
            } else {
                nodeB?.removeFromParent()
            }
            playerPlaneController.changeBullet(self, bulletType: DOUBLE_BULLET_TYPE)
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesBegan")
        // 1

    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        print("touches count: \(touches.count)")
        if let touch = touches.first {
            // 1
            let currentTouchPosition = touch.locationInNode(self)
            let previousTouchPosition = touch.previousLocationInNode(self)
            
            playerPlaneController.moveBy(currentTouchPosition.subtract(previousTouchPosition))
            
            
            
//            if(playerPlaneController.view.position.x < 0) {
//                playerPlaneController.view.position.x = 0
//            }
//            
//            if (playerPlaneController.view.position.x > self.frame.width) {
//                playerPlaneController.view.position.x = self.frame.width
//            }
//            
//            if (playerPlaneController.view.position.y - playerPlaneController.view.size.height/2 < 0 || playerPlaneController.view.position.y - playerPlaneController.view.size.height/2 == 0  ) {
//                playerPlaneController.view.position.y = playerPlaneController.view.size.height/2
//            }
//            
//            if (playerPlaneController.view.position.y + playerPlaneController.view.size.height/2 > self.frame.height) {
//                playerPlaneController.view.position.y = self.frame.height - playerPlaneController.view.size.height/2
//            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        print("\(currentTime)")
        
//        self.enumerateChildNodesWithName("enemy") {
//            enemyNode, _ in
//            self.enumerateChildNodesWithName("bullet") {
//                bulletNode, _ in
//                let bulletFrame = bulletNode.frame
//                let enemyFrame = enemyNode.frame
//                
//                // 2
//                if CGRectIntersectsRect(bulletFrame, enemyFrame) {
//                    // 3
//                    bulletNode.removeFromParent()
//                    enemyNode.removeFromParent()
//                    
//                }
//            }
//        }
    }
    
    func addEnemy(spawnRate: NSTimeInterval) {
        
        // create enemy
        
        let enemySpawn = SKAction.runBlock{
            // create
            let enemyView = View(imageNamed: "enemy_plane_white_1")
            enemyView.size = CGSize(width: 50, height: 50)
            
            // position
            let positionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - enemyView.frame.width))) + enemyView.frame.width/2
            
            enemyView.position = CGPoint(x: positionX, y: self.frame.maxY)
            
            // animate
            var textures = [SKTexture]()
            let nameFormat = "enemy_plane_white_"
            for i in 1...3 {
                let nameImage = nameFormat + String(i)
                let texture = SKTexture(imageNamed: nameImage)
                textures.append(texture)
            }
            
            let animate = SKAction.animateWithTextures(textures, timePerFrame: 0.017)
            enemyView.runAction(SKAction.repeatActionForever(animate))
            
            // addController
            let enemyPlaneController = EnemyPlaneController(view: enemyView)
            enemyPlaneController.setup(self)
            
            //
            self.addChild(enemyView)
        }
        
        let enemyAction = SKAction.sequence([enemySpawn, SKAction.waitForDuration(spawnRate)])
        
        self.runAction(SKAction.repeatActionForever(enemyAction))
        
    }
    

    
    func addBackground() {
        // 1
        let background = SKSpriteNode(imageNamed: "background.png")
        
        // 2
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        
        // 3
        addChild(background)
    }
    
    func addPlane() {
        // 1
        let planeView = View(imageNamed: "plane3.png")
        
        // 2
        planeView.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
//        // 3
//        let shot = SKAction.runBlock {
//            self.addBullet()
//        }
        
        self.playerPlaneController = PlayerPlaneController(view: planeView)
        self.playerPlaneController.setup(self)
//        
//        let periodShot = SKAction.sequence([shot, SKAction.waitForDuration(0.3)])
//        let shotForever = SKAction.repeatActionForever(periodShot)
//        
//        
//        // 4
//        plane.runAction(shotForever)
        
        // 5
        addChild(planeView)
    }
    
    
    func addPowerUp(spawnRate: NSTimeInterval) {
        
        let powerUpSpawn = SKAction.runBlock {
            
            let powerUpView = View(imageNamed: "power-up.png")
            
            let positionX = CGFloat(arc4random_uniform(UInt32(self.frame.maxX - powerUpView.frame.width))) + powerUpView.frame.width/2
            
            powerUpView.position = CGPoint(x: positionX, y: self.frame.height)
            
            let powerUpController = PowerUpController(view: powerUpView)
            
            powerUpController.setup(self)
            
            self.addChild(powerUpView)
        }
        
        let powerUpAction = SKAction.sequence([SKAction.waitForDuration(spawnRate), powerUpSpawn])
        self.runAction(SKAction.repeatActionForever(powerUpAction))
    }
    
}