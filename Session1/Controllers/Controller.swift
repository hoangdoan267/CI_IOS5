//
//  Controller.swift
//  Session1
//
//  Created by Hoang Doan on 9/22/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class Controller {
    
    internal let view: View
    
    func setup(parent: SKNode) -> Void {
       
    }
    
    init(view :View) {
        self.view = view
    }
    
    func moveTo(position: CGPoint) -> Void {
        self.view.position = position
    }
    
    func moveBy(vector: CGPoint) -> Void {
        let newPosition = self.view.position.add(vector)
        self.view.position = newPosition
    }
}
