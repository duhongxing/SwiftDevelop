//
//  DuCoreAnimationViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/4.
//

import UIKit

class DuCoreAnimationViewController: DuBaseViewController {
    
    let duView = UIView()
    
    
    override func loadView() {
        super.loadView()
        print("\(#function)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(#function)")
        
        //let layer = testLayer()
        
        //testBasicAnimation(layer)
        
        testCAKeyframeAnimation()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("\(#function)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("\(#function)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("\(#function)")
    }
    
    
    
    func testLayer() -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100)
        layer.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(layer)
        
        //        layer.borderWidth = 2
        //        layer.borderColor = UIColor.blue.cgColor
        //        layer.cornerRadius = 5
        //        layer.shadowColor = UIColor.yellow.cgColor
        //        layer.shadowOffset = CGSize(width: 5, height: 5)
        
        return layer
    }
    
    func testBasicAnimation(_ layer: CALayer) {
        let animation = CABasicAnimation(keyPath: "opactiy")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 1.0
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        layer.add(animation, forKey: "opactityAnimation")
    }
    
    func testCAKeyframeAnimation() {
        
        let  duView = UIView()
        
        duView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        duView.backgroundColor = .blue
        view.addSubview(duView)
        
        
        // 创建 CAKeyframeAnimation 对象
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        // 设置关键帧
        animation.values = [
            NSValue(cgPoint: CGPoint(x: 50, y: 50)),
            NSValue(cgPoint: CGPoint(x: 250, y: 50)),
            NSValue(cgPoint: CGPoint(x: 250, y: 450)),
            NSValue(cgPoint: CGPoint(x: 50, y: 450)),
            NSValue(cgPoint: CGPoint(x: 50, y: 50))
        ]
        
        // 设置关键帧的时间点
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        
        // 设置动画的时长、重复次数和自动反转
        animation.duration = 4.0
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        
        // 将动画添加到视图的图层
        duView.layer.add(animation, forKey: "positionAnimation")
    }
    
    
}
