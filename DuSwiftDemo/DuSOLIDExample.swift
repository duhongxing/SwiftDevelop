//
//  DuSOLIDExample.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/2/6.
//

/**
 SOLID 是面向对象编程和设计中的五个基本原则的首字母缩写。它们有助于开发者创建更加健壮、可维护和可扩展的系统。以下是对每个原则的概述和示例代码：

 1. 单一职责原则 (Single Responsibility Principle, SRP)：一个类应该只有一个引起变化的原因，即一个类只负责一个职责。

 2. 开放封闭原则 (Open/Closed Principle, OCP)：软件实体（类、模块、函数等）应该对扩展开放，对修改封闭。

 3. 里氏替换原则 (Liskov Substitution Principle, LSP)：子类对象必须能够替换其基类对象，并且程序的行为保持不变。

 4. 接口隔离原则 (Interface Segregation Principle, ISP)：客户端不应该被迫依赖于它们不使用的方法。

 5. 依赖倒置原则 (Dependency Inversion Principle, DIP)：高层模块不应该依赖于低层模块，二者都应该依赖于抽象。抽象不应该依赖于细节，细节应该依赖于抽象。
 
 */

import Foundation

// MARK: - 单一职责原则（SRP）
class User {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

class UserRepository {
    func save(user: User) {
        // 保存用户到数据库
    }
}

// MARK: - 开放封闭原则（OCP）
protocol Shape {
    func area() -> Double
}

class Rectangle: Shape {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func area() -> Double {
        return width * height
    }
}

class Circle: Shape {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
}

// MARK: - 里氏替换原则（LSP）
class Bird {
    func fly() {
        
    }
}

class Sparrow: Bird {
    override func fly() {
        // 麻雀飞行
    }
}

class Ostrich: Bird {
    // 鸵鸟不能飞，因此不能写fly方法
    func run() {
        // 鸵鸟奔跑
    }
}

// MARK: - 接口隔离原则（ISP）
protocol Printer {
    func printDocument()
}

protocol Scanner {
    func scanDocument()
}

class AllInOnePrinter: Printer, Scanner {
    func printDocument() {
        // 打印文档
    }
    
    func scanDocument() {
        // 扫描文档
    }
}

class SimplePrinter: Printer {
    func printDocument() {
        // 打印文档的实现
    }
}

// MARK: - 依赖倒置原则（DIP）

/**
 依赖倒置原则 (Dependency Inversion Principle) 是 SOLID 原则中的一项，它强调高层模块不应该依赖于低层模块，而是共同依赖于抽象。抽象不应该依赖于细节，细节应该依赖于抽象。
 
 1. DataService 协议定义了一个抽象的数据服务。
 2. APIService 和 LocalService 类分别实现了 DataService 协议。
 3. DataManager 类依赖于 DataService 协议，而不是具体的 APIService 或 LocalService 实现。
 4. 在创建 DataManager 实例时，通过依赖注入的方式将具体的 DataService 实现传递给 DataManager，从而实现了依赖倒置原则。
 
 */

// 定义一个协议，用于抽象底层模块的行为
protocol DataService {
    func fetchData() -> String
}

// 具体的底层模块实现该协议
class APIService: DataService {
    func fetchData() -> String {
        return "Data from API"
    }
}

class LocalService: DataService {
    func fetchData() -> String {
        return "Data from Local Storage"
    }
}

// 高层模块依赖于抽象（协议），而不是具体的实现
class DataManager {
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getData() -> String {
        return dataService.fetchData()
    }
}

func test() {
    // 使用依赖注入来注入具体实现
    let apiService = APIService()
    let dataManager1 = DataManager(dataService: apiService)
    print(dataManager1.getData())
    
    let localService = LocalService()
    let dataManager2 = DataManager(dataService: localService)
    print(dataManager2.getData())
}

