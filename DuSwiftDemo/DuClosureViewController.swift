//
//  DuClosureViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/3.
//

import UIKit

protocol pc {
    associatedtype T
    mutating func add(_ p: T)
}

struct DuStruct: pc {
    typealias T = String
    var strs = [String]()
    func add(_ p: String) {
        
    }
}


/**
 闭包是自包含的代码块，可以在代码中捕获和存储变量和常量

 */

class DuClosureViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let closure = { (a: Int, b: Int) -> Int in
            return a + b
        }
        
        let result = closure(1, 3)
        
        print(result)
        
    }
}
