//
//  GameMenu.swift
//  Session1
//
//  Created by Hoang Doan on 9/22/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import Foundation
import SpriteKit

class GameMenu : SKScene {
    override func didMoveToView(view: SKView) {
        let label = SKLabelNode(text: "Tab to play")
        label.fontName = "Tahoma"
        label.position = CGPoint(x: self.frame.size.width/2, y:  self.frame.size.height/2)
        addChild(label)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let gameScene = GameScene(size: (self.view?.frame.size)!)
        self.view?.presentScene(gameScene, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1))
    }
}