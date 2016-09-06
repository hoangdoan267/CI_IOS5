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
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        
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
        //1
        plane = SKSpriteNode(imageNamed: "plane3.png")
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        
        addChild(plane)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        print("touchBegan")
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        print("touches: \(touches.count)")
        if let touch = touches.first {
            let currentTouch = touch.locationInNode(self)
            let previousTouch = touch.previousLocationInNode(self)
            
//            let movementVector = currentTouch.subtract(previousTouch)
//            
//            let newPosition = movementVector.add(plane.position)
           
            plane.position = currentTouch.subtract(previousTouch).add(plane.position)
            
            let multiExmaple = plane.position.multiply(2)
            
            
            
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
            
            print("Vi tri may bay: \(plane.position)")
            print("Diem sau khi multiply: \(multiExmaple)")
            print("Distance: \(currentTouch.distance(previousTouch))")
            
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
