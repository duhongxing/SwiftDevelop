//
//  DuStructClassViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/2/26.
//

import UIKit

class DuStructClassViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test_defer()
    }
    

    func test_defer() {
        print(" --- start --- ")
        
        defer {
            print(" --- defer 1 --- ")
        }
        
        print(" --- middle --- ")
        
        defer {
            print(" --- defer 2 --- ")
        }
        
        print(" --- end of func --- ")
    }

}
