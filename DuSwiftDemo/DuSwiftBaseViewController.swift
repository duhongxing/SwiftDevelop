//
//  DuSwiftBaseViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/13.
//

import UIKit

class DuSwiftBaseViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testString()

        // Do any additional setup after loading the view.
    }

}

// MARK: 方法

/**
 在 Swift 中，方法的派发机制主要分为静态派发（Static Dispatch）和动态派发（Dynamic Dispatch）。这两种派发机制影响了方法调用的效率和灵活性。下面对这两种派发机制进行详细介绍。
 
 静态派发（Static Dispatch）
 静态派发是一种在编译时确定方法调用的机制。在静态派发中，编译器会在编译时确定方法的具体实现，并在生成的代码中直接调用该方法。这种机制通常用于类和结构体中的 final 方法或私有方法。静态派发的优点是效率高，因为在运行时不需要查找方法的具体实现。缺点是灵活性较低，不能在运行时改变方法的实现。
 
 动态派发（Dynamic Dispatch）
 动态派发是一种在运行时确定方法调用的机制。在动态派发中，方法的具体实现是在运行时通过查找方法表（VTable）来确定的。这种机制通常用于类的非 final 方法。动态派发的优点是灵活性高，可以在运行时改变方法的实现。缺点是效率较低，因为每次方法调用都需要在运行时查找方法的具体实现。
 
 总结
 静态派发：在编译时确定方法调用，效率高，但灵活性低。通常用于 final 方法或私有方法。
 动态派发：在运行时确定方法调用，灵活性高，但效率低。通常用于类的非 final 方法。
 选择使用哪种派发机制取决于具体的需求和应用场景。在性能要求较高的情况下，可以优先考虑静态派发；在需要较高灵活性的情况下，可以选择动态派发。
 
 */

extension DuSwiftBaseViewController {
    class Animal {
        func makeSound() {
            print("Animal sound")
        }
    }
    
    class Dog: Animal {
        override func makeSound() {
            print("Bark")
        }
        
        final func run() {
            print("dog running")
        }
    }
}


// MARK: Swift OC 互相调用

extension DuSwiftBaseViewController {
    
}

// MARK: subscript

extension DuSwiftBaseViewController {
    class DuSubscript {
        private var values: [Int] = [1, 2, 3, 4, 5]
        subscript(index: Int) -> Int {
            get {
                return values[index]
            }
            set (newValue) {
                values[index] = newValue
            }
        }
    }

    enum DuHumanType {
        case boy
        case girl
        
        init?(tag: String) {
            switch tag.lowercased() {
            case "b":
                self = .boy
            case "g":
                self = .girl
            default:
                return nil
            }
        }
        
        func description() -> String {
            switch self {
            case .boy:
                return "boy"
            case .girl:
                return "girl"
            }
        }
    }
}


//MARK: String
extension DuSwiftBaseViewController {
    func testString() {
        let s = "abcdef"
       
    }
}
