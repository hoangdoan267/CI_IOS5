//
//  PlayerPlaneController.swift
//  Session1
//
//  Created by Hoang Doan on 9/22/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class PlayerPlaneController: Controller {
    
    
    override func setup(parent: SKNode) {
        addShotAction(parent, bulletType: SINGLE_BULLET_TYPE)
        configurePhysics()
    }
    
    
    func configurePhysics() {
        
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = (PHYSICS_MASK_ENEMY | PHYSICS_MASK_ENEMY_BULLET)
    }
    
     private func addShotAction(parent: SKNode, bulletType: Int) -> Void {
        self.view.runAction(
            SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock {
                        self.addBullet(parent,bulletType: bulletType)
                    },
                    SKAction.waitForDuration(0.5)
                ])
            ), withKey: "Shot"
        )
    }
    
    private func addBullet(parent: SKNode, bulletType: Int) {
        
        var bulletView = View()
        
        if bulletType == SINGLE_BULLET_TYPE {
            bulletView = View(imageNamed: "bullet")
        } else if bulletType == DOUBLE_BULLET_TYPE {
            bulletView = View(imageNamed: "bullet-double")
        }
        
        bulletView.position = view.position.add(CGPoint(x: 0, y: view.frame.height/2 + bulletView.frame.height/2))
        
        let bulletController = BulletController(view: bulletView)
        
        bulletController.setup(parent)
        
        parent.addChild(bulletController.view)
        
        
    }
    
    func changeBullet(parent: SKNode, bulletType: Int){
        view.removeActionForKey("Shot")
        addShotAction(parent, bulletType: bulletType)
    }
}
