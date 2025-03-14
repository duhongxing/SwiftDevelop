//
//  DuCopyOnWriteViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/2/6.
//

import UIKit

class CopyOnWrite {
    var array: [Int]
    
    init(array: [Int]) {
        self.array = array
    }
}

class DuCopyOnWriteViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var original = CopyOnWrite(array: [1, 2, 3])
        var copy = original
        print("original array: \(original.array)")
        print("copy array: \(copy.array)")
        
        //修改copy的数组
        copy.array.append(4)
        
        print("original array after modification: \(original.array)")
        print("copy array after modification: \(copy.array)")

        // Do any additional setup after loading the view.
    }
    

    

}
