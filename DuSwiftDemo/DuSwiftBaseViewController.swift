//
//  DuSwiftBaseViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/13.
//

import UIKit

/*
 类型
 值类型
 - 基础数值类型
 - 结构体 struct
 - 枚举 enum
 - 元组 tuple
 - 特殊类型
    - String
    - Array
    - Dictionary
    - Set
 
 引用类型 reference type
 - 类 class
 - 闭包 closure
 
 类型装饰
 - 协议 protocol
 - 扩展 extension
 - 泛型 generics
 
 
 */

class DuSwiftBaseViewController: DuBaseViewController {
    
    struct AgeDog {
        var name: String
        var age: Int
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testString()
        testSwiftClass()
        testClosures()
        testSubscript()
        testOptional()
        
        let a1 = AgeDog(name: "xx", age: 9)
        var a2 = a1
        print(a1, a2)
        a2.age = 10
        print(a1, a2)

        // Do any additional setup after loading the view.
    }

}

// MARK: 方法 静态派发 & 动态派发

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

// MARK: 类
/*
 类、结构体、枚举都可以定义初始化器
 类有2种初始化器: 指定初始化器(designated initializer)、便捷初始化器(convenience initializer)
 
 规则:

 每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
 默认初始化器总是类的指定初始化器
 类偏向于少量指定初始化器，一个类通常只有一个指定初始化器

 初始化器的相互调用规则

 指定初始化器必须从它的直系父类调用指定初始化器
 便捷初始化器必须从相同的类里调用另一个初始化器
 便捷初始化器最终必须调用一个指定初始化器
 
 */
extension DuSwiftBaseViewController {
    class Animal {
        var name: String
        var age: Int
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        convenience init(name: String) {
            self.init(name: name, age: 18)
        }
        
        convenience init() {
            self.init(name: "Unknown", age: 0)
        }
        
        func makeSound() {
            print("Animal sound")
        }
    }
    
    class Dog: Animal {
        
        // 添加新属性 存储属性
        var breed: String
        
        /*
         计算属性
         本质就是方法(函数)
         不占用实例对象的内存
         枚举、结构体、类都可以定义计算属性
         */
        var identifier: String {
            "\(name)-\(age)"
        }
        
        var isRunning: Bool = false {
            // 属性观察是指在当前类型内对特性属性进行监测,并作出响应
            willSet(newValue) {
                print("willSet: \(newValue)")
            }
            
            didSet {
                print("oldValue: \(oldValue) currentValue: \(isRunning)")
            }
        }
        
        /*
         延迟属性 使用lazy可以定义一个延迟存储属性，在第一次用到属性的时候才会进行初始化(类似OC中的懒加载)
         
         lazy属性必须是var，不能是let

         let必须在实例对象的初始化方法完成之前就拥有值
         如果多条线程同时第一次访问lazy属性

         无法保证属性只被初始化1次
         */
        lazy var image: UIImage? = {
            return UIImage(named: "Animal")
        }()
        
        // 子类初始化
        init(name: String, age: Int, breed: String) {
            self.breed = breed
            super.init(name: name, age: age)
        }
        
        // 子类重写父类方法
        override func makeSound() {
            print("Bark")
        }
        
        // 静态派发方法
        final func run() {
            isRunning = true
            print("dog running")
        }
        
        // 类方法
        class func eatFood() {
            print(5,6, separator: "&")
        }
    }
    
    func testSwiftClass() {
        let dog = Dog(name: "小黄", age: 5, breed: "汪汪")
        dog.run()
    }
}


// MARK: Swift OC 互相调用

extension DuSwiftBaseViewController {
    
}

// MARK: subscript
/*
 使用subscript可以给任意类型(枚举、结构体、类)增加下标功能，有些地方也翻译为:下标脚本
 subscript的语法类似于实例方法、计算属性，本质就是方法(函数)
 */

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
    
    
    class Point {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            set {
                if index == 0 {
                    x = newValue
                } else if index == 1 {
                    y = newValue
                }
            }
            
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    
    func testSubscript() {
        var p = Point()
        p[0] = 11.1
        p[1] = 22.2
        print(p.x, p.y)
    }
}

// MARK: 访问控制

/*
 open: 可以在模块内外访问和继承
 public: 可以在模块内外访问，但不能继承
 internal: 只能在模块内访问（默认）
 fileprivate: 只能在定义它的文件内访问
 private: 只能在定义它的作用域内访问
 */

extension DuSwiftBaseViewController {
    class SomeClass {
        private var privateProperty: Int = 0
        fileprivate var filePrivateProperty: Int = 1
        internal var internalProperty: Int = 2
        public var publicProperty: Int = 3
        open var openProperty: Int = 4
    }
}


//MARK: String
extension DuSwiftBaseViewController {
    func testString() {
        let subs = "abcdef".map({String($0)})
        
    }
}

//MARK: 优化Swift代码性能的建议
/*
 
 基本性能优化指南和最佳实践
 减少不必要的对象创建：避免频繁创建和销毁对象，尤其是在循环中。
 使用值类型：优先使用结构体（struct）而不是类（class），因为结构体是值类型，性能更好。
 避免使用强制解包：尽量减少使用!进行强制解包，使用可选绑定（optional binding）和可选链式调用（optional chaining）代替。
 使用懒加载：对于某些变量，可以使用lazy关键字进行懒加载，只有在需要时才初始化。
 减少方法调用的开销：将频繁调用的方法内联（inline），避免方法调用开销。
 使用高效的数据结构：选择合适的数据结构，如使用Array、Set、Dictionary等标准库提供的数据结构。
 
 
 常见性能陷阱
 滥用ARC（自动引用计数）：避免循环引用，使用weak或unowned关键字打破循环引用。
 频繁的UI更新：避免在主线程上频繁更新UI，可以使用DispatchQueue进行异步操作。
 过度使用动态派发：尽量减少使用@objc和dynamic修饰符，因为这会导致性能开销。
 
 高级优化技巧
 使用final关键字：对于不需要继承的类，使用final关键字可以提高编译器优化的机会。
 内存管理优化：使用UnsafePointer、UnsafeMutablePointer等进行手动内存管理，但要小心内存泄漏和非法访问。
 并行处理：利用GCD（Grand Central Dispatch）进行并行计算，充分利用多核处理器的性能。

 工具和库
 Instruments：使用Xcode自带的Instruments工具进行性能分析和调试。
 SwiftLint：使用SwiftLint进行代码规范检查，避免潜在的性能问题。
 Benchmarking工具：使用XCTest框架进行性能测试，编写基准测试（benchmark）来测量代码性能。
 
 开源项目中的优化实例
 可以参考一些开源项目中的优化实例，学习它们的优化技巧和方法。例如：

 Swift Standard Library：Swift标准库的源码中有许多性能优化的实例。
 Vapor：Vapor是一个流行的Swift Web框架，其中也包含许多性能优化的实践。
 性能基准和分析工具
 Xcode Instruments：用于分析内存使用、CPU占用、磁盘I/O等性能指标。
 Time Profiler：用于分析代码执行时间，找出性能瓶颈。
 Allocations：用于分析内存分配情况，找出内存泄漏和不合理的内存使用。
 
 */

extension DuSwiftBaseViewController {
    // 性能
    func testPerformance() {
        
    }
}


//MARK: 闭包
extension DuSwiftBaseViewController {
    
    func testClosures() {
        // 全局函数： 有名字但不能捕获任何至
        // 嵌套函数： 有名字并能从其封闭函数中捕获值
        // 闭包表达式：无名闭包，使用轻量级语法编写，可以捕获其上下文中的值
        
        let c = { a in
            print(a)
        }
        
        c(10)
    }
}

//MARK: 关联类型
extension DuSwiftBaseViewController {
    protocol Cocol {
        associatedtype Item
        mutating func append(_ item: Item)
        var count: Int { get }
        subscript(i: Int) -> Item { get }
    }
}


//MARK: 值类型和引用类型
/*
 值类型和引用类型相比,最大优势可以高效的使用内存,值类型在栈上操作,引用类型在堆上操作,栈上操作仅仅是单个指针的移动,而堆上操作牵涉到合并,位移,重链接,Swift 这样设计减少了堆上内存分配和回收次数,使用 copy-on-write将值传递与复制开销降到最低
 */

extension DuSwiftBaseViewController {
    
}

//MARK: 协议可选
extension DuSwiftBaseViewController {
    @objc protocol DuProtocol {
        @objc optional func test()
    }
}

protocol SomeProtocol {
    func someFunc()
}

extension SomeProtocol {
    func someFunc() {
        print("some function")
    }
}

//MARK: 初始化方法
/*
 convenience只提供一种方便的初始化器,必须通过一个指定初始化器来完成初始化
 required是强制子类重写父类中所修饰的初始化方法
 */
extension DuSwiftBaseViewController {
    
}

//MARK: 可选链
/*
 可选链是一个调用和查询可选属性、方法和下标的过程，它可能为 nil 。如果可选项包含值，属性、方法或者下标的调用成功；如果可选项是 nil ，属性、方法或者下标的调用会返回 nil 。多个查询可以链接在一起，如果链中任何一个节点是 nil ，那么整个链就会得体地失败。

 多个?可以链接在一起
 如果链中任何一个节点是nil，那么整个链就会调用失败
 */
extension DuSwiftBaseViewController {
    class DuOptionalC {
        var text: String?
        var num: Int?
        weak var c: DuOptionalC?
        
        init(text: String? = nil, num: Int? = nil) {
            self.text = text
            self.num = num
        }
    }
    
    
    func testOptional() {
        let c1 = DuOptionalC(text: "你好，optional 1", num: 2025)
        let c2 = DuOptionalC(text: "你好，optional 2", num: 2025)
        c1.c = c2
        print(c1.c?.text ?? "")
    }
}

//MARK: 类、结构体、枚举可以为现有的运算符提供自定义的实现，这个操作叫做:运算符重载

extension DuSwiftBaseViewController {
    func testOperation() {
        
    }
}

//MARK: 面相协议编程
extension DuSwiftBaseViewController {
    
    protocol Travelable {
        var price: Int { get set }
        var transportation: Bool { get set }
    }
    
    class Transportation: Travelable {
        var price: Int
        var transportation: Bool
        var color: UIColor
        init(price: Int, transportation: Bool, color: UIColor) {
            self.price = price
            self.transportation = transportation
            self.color = color
        }
    }
    
    class Car: Transportation {
        
    }
    
    class Horse: Animal, Travelable {
        var price: Int
        var transportation: Bool
        init(price: Int, transportation: Bool) {
            self.price = price
            self.transportation = transportation
            super.init(name: "horse", age: 5)
        }
    }
    
    
}
