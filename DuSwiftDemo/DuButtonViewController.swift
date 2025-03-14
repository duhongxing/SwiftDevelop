//
//  DuButtonViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/15.
//

import UIKit

class DuButtonViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let myCar = Car(speed: 120)
        print(myCar.description())


        let mySuperCar = SuperCar()
        mySuperCar.drive()
        mySuperCar.fly()

        var intBox = Box<Int>()
        intBox.add(item: 1)
        print(intBox.items)

        let sumInt = add(1, 2)
        let sumDobule = add(1.0, 2.0)
        print(sumInt)
        print(sumDobule)

    }

}

// MARK: - Protocol Extensions
protocol Vehicle {
    var speed: Int { get }
}

extension Vehicle {
    func description() -> String {
        return "Speed: \(speed)"
    }
}

struct Car: Vehicle {
    var speed: Int
}

// MARK: - Protocol Composition
protocol Drivable {
    func drive()
}

protocol Flyable {
    func fly()
}

typealias FlyingCar = Drivable & Flyable

struct SuperCar: FlyingCar {
    func drive() {
        print("Driving")
    }

    func fly() {
        print("Flying")
    }
}

// MARK: - 关联类型
protocol Container {
    associatedtype Item
    var items: [Item] { get }

    mutating func add(item: Item)
}

struct Box<T>: Container {
    var items = [T]()
    mutating func add(item: T) {
        items.append(item)
    }
}

// MARK: - 协议与泛型
protocol Summable {
    static func +(lhs: Self, rhs: Self) -> Self
}

func add<T: Summable>(_ a: T, _ b: T) -> T {
    return a + b
}

extension Int: Summable {}
extension Double: Summable {}

