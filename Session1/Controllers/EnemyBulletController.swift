//
//  EnemyBulletController.swift
//  Session1
//
//  Created by Hoang Doan on 9/25/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class EnemyBulletController: Controller {
    
    let SPEED: CGFloat = 200
    override func setup(parent: SKNode) {
        addActionFly(parent)
        configurePhysics()
    }
    
    func configurePhysics(){
        
        view.physicsBody = SKPhysicsBody(rectangleOfSize: view.frame.size)
        
        view.physicsBody?.categoryBitMask = PHYSICS_MASK_ENEMY_BULLET
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.contactTestBitMask = PHYSICS_MASK_PLAYER
    }
    
    
    private func addActionFly(parent: SKNode) {
        let distanceToBottom = view.position.y
        let timeToReachBottom = Double(distanceToBottom / SPEED)
        
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
