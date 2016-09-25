//
//  PowerUpController.swift
//  Session1
//
//  Created by Hoang Doan on 9/25/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class PowerUpController: Controller {
    
    let SPEED: Double = 300
    
    override func setup(parent: SKNode) {
        addActionFly(parent)
        configurePhysics()
    }
    
    func configurePhysics() {
        
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_POWERUP
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER
    }
    
    func addActionFly(parent: SKNode) {
        let timeToReachBottom = Double(parent.frame.height) / SPEED
        self.view.runAction(
            SKAction.sequence(
                [
                    SKAction.moveToY(-view.frame.height, duration: timeToReachBottom),
                    SKAction.removeFromParent()
                ]
            )
            
        )
    }
}
