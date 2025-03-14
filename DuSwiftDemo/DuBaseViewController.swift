//
//  DuBaseViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/4.
//

import UIKit
import SnapKit

@objc class DuBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .randomColor

        // Do any additional setup after loading the view.

        // 方法交换的用途
        /**
         1. 扩展或修改现有方法 在不需要子类化的情况下，对框架或第三方库中的方法进行扩展或修改
         2. 调试或日志记录 知道某个方法被调用，但无法修改源码，此时可以交换方法来自定义输出日志，或者来衡量某个方法的性能如何
         3. 实现跨领域关注点 如在多个方法或类中实现认证或缓存功能
         */
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }

}


extension UIColor {
    static var randomColor: UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
