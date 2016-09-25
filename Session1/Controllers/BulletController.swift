//
//  BulletController.swift
//  Session1
//
//  Created by Hoang Doan on 9/22/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BulletController : Controller {
    
    let SPEED :Double = 1000
    
    override func setup(parent: SKNode) {
        addFlyAction(parent)
        configurePhysics()
    }
    
    func addFlyAction(parent: SKNode) -> Void {
        let distanceToRoot = Double(parent.frame.height - self.view.frame.height)
        let timeToReachRoot = distanceToRoot/SPEED
        self.view.runAction(
            SKAction.sequence([
                SKAction.moveToY(parent.frame.height, duration: timeToReachRoot),
                SKAction.removeFromParent()
            ])
        )
    }
    
    func configurePhysics() -> Void {
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_PLAYER_BULLET
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_ENEMY
    }
}

