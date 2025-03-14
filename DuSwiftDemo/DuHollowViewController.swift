//
//  DuHollowViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/4.
//

import UIKit

class DuHollowViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)
        view.addSubview(backgroundView)

        let path = UIBezierPath(rect: view.bounds)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: view.center.y - 25), radius: 50, startAngle: 0, endAngle: 2 * Double.pi, clockwise: false)
        path.append(circlePath)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        backgroundView.layer.mask = shapeLayer

        // Do any additional setup after loading the view.
    }
    


}
