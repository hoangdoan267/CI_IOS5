//
//  GameScene.swift
//  Session1
//
//  Created by Hoang Doan on 8/28/16.
//  Copyright (c) 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var plane: SKSpriteNode!
    var bullets : [SKSpriteNode] = []
    var enemies : [SKSpriteNode] = []
    var lastTimeUpdate : NSTimeInterval = -1
    var bulletTime = 0
    var enemyTime = 0
    
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        addEnemy()
        
    }
    
    func addBackground() {
        //1
        let background = SKSpriteNode(imageNamed: "background.png")
        //2
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        //3
        addChild(background)
        
    }
    
    func addPlane() {
        plane = SKSpriteNode(imageNamed: "plane3.png")
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        let shot = SKAction.runBlock {
            self.addBullet()
        }
        let periodShot = SKAction.sequence([shot, SKAction.waitForDuration(0.3)])
        
        let shotForever = SKAction.repeatActionForever(periodShot)

        plane.runAction(shotForever)
        
        addChild(plane)
    }
    
    func addBullet() {
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        
        bullet.position.x = plane.position.x
        bullet.position.y = plane.position.y + plane.size.height
        
        let fly = SKAction.moveByX(0, y: 20, duration: 0.05)
        bullet.runAction(SKAction.repeatActionForever(fly))
        
        addChild(bullet)
        bullets.append(bullet)
    }
    
    func addEnemy() {
        let add = SKAction.runBlock{
            let enemy = SKSpriteNode(imageNamed: "plane1.png")
            
            enemy.position.x = self.frame.width/2
            enemy.position.y = self.frame.height
            
            let move = SKAction.moveByX(0, y: -15, duration: 0.1)
            enemy.runAction(SKAction.repeatActionForever(move))
            
            self.addChild(enemy)
            self.enemies.append(enemy)
        }
        
        let enemyPeriod = SKAction.sequence([add, SKAction.waitForDuration(5)])
        self.runAction(SKAction.repeatActionForever(enemyPeriod))
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if let touch = touches.first {
            let currentTouch = touch.locationInNode(self)
            let previousTouch = touch.previousLocationInNode(self)
            
            plane.position = currentTouch.subtract(previousTouch).add(plane.position)
            
            
            if(plane.position.x < 0) {
                plane.position.x = 0
            }
            
            if (plane.position.x > self.frame.width) {
                plane.position.x = self.frame.width
            }
            
            if (plane.position.y - plane.size.height/2 < 0 || plane.position.y - plane.size.height/2 == 0  ) {
                plane.position.y = plane.size.height/2
            }
            
            if (plane.position.y + plane.size.height/2 > self.frame.height) {
                plane.position.y = self.frame.height - plane.size.height/2
            }
            
            
            
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
     
        for (bulletIndex ,bullet) in bullets.enumerate() {
            for (enemyIndex ,enemy) in enemies.enumerate() {
                let bulletFrame = bullet.frame
                let enemyFrame = enemy.frame
                
                if CGRectIntersectsRect(bulletFrame, enemyFrame) {
                    bullet.removeFromParent()
                    enemy.removeFromParent()
                    
                    enemies.removeAtIndex(enemyIndex)
                    bullets.removeAtIndex(bulletIndex)
                }
            }
        }
        
   }
}

