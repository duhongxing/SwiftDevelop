//
//  DuButton.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/25.
//

import UIKit

class DuButton: UIButton {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        super.hitTest(point, with: event)
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
    }

}
