//
//  DuDesignPatternsViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/13.
//

/**
 1. MVC（Model-View-Controller）
 MVC 是 iOS 开发中最常用的设计模式之一。它将应用程序分为三个部分：

 Model：负责数据和业务逻辑
 View：负责界面显示
 Controller：负责协调 Model 和 View 之间的交互
 
 2. MVVM（Model-View-ViewModel）
 MVVM 模式在 MVC 的基础上引入了 ViewModel 层，从而简化了 Controller 的职责。具体如下：

 Model：负责数据和业务逻辑
 View：负责界面显示
 ViewModel：负责处理视图逻辑和数据绑定
 
 3. MVP（Model-View-Presenter）
 MVP 模式将 MVC 中的 Controller 替换为 Presenter，从而使 View 和 Model 之间的耦合度更低。具体如下：

 Model：负责数据和业务逻辑
 View：负责界面显示
 Presenter：负责处理业务逻辑和与 View 的交互
 
 4. 单例模式（Singleton）
 单例模式确保一个类只有一个实例，并提供一个全局访问点。常用于管理共享资源，如网络连接、数据库连接等。

 5. 工厂模式（Factory）
 工厂模式定义了一个用于创建对象的接口，但由子类决定实例化哪个类。常用于创建复杂对象时隐藏实例化的具体细节。

 6. 观察者模式（Observer）
 观察者模式定义了对象之间的一对多依赖关系，当一个对象改变状态时，所有依赖它的对象都会收到通知并自动更新。常用于事件驱动的系统中，如通知机制。

 7. 委托模式（Delegate）
 委托模式允许一个对象将其职责的一部分委托给另一个对象。常用于处理 View 和 Controller 之间的交互。

 8. 适配器模式（Adapter）
 适配器模式将一个类的接口转换成客户希望的另一个接口，使得原本由于接口不兼容而不能一起工作的类可以协同工作。

 9. 装饰模式（Decorator）
 装饰模式动态地将责任附加到对象上。提供了比继承更灵活的替代方案来扩展类的功能。

 10. 策略模式（Strategy）
 策略模式定义了一系列算法，并将每一个算法封装起来，使它们可以相互替换。本模式使得算法可以独立于使用它的客户而变化。

 11. 组合模式（Composite）
 组合模式允许你将对象组合成树形结构来表示“部分-整体”的层次结构。组合模式使得用户对单个对象和组合对象的使用具有一致性。

 12. 备忘录模式（Memento）
 备忘录模式在不破坏封装的前提下，捕获并保存对象的内部状态，以便以后恢复它。

 13. 代理模式（Proxy）
 代理模式为其他对象提供一种代理以控制对这个对象的访问。常用于懒加载、访问控制等场景。

 14. 桥接模式（Bridge）
 桥接模式将抽象部分与它的实现部分分离，使它们都可以独立地变化。

 15. 命令模式（Command）
 命令模式将一个请求封装为一个对象，从而使你可用不同的请求对客户进行参数化；对请求排队或记录请求日志，以及支持可撤销的操作。

 16. 模板方法模式（Template Method）
 模板方法模式在一个方法中定义一个算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以在不改变算法结构的情况下，重新定义算法中的某些步骤。

 17. 状态模式（State）
 状态模式允许对象在内部状态改变时改变它的行为。对象看起来好像修改了它的类。

 18. 责任链模式（Chain of Responsibility）
 责任链模式为请求创建了一个接收者对象的链。这种模式给予请求的类型，使多个对象都有机会处理该请求。避免了请求的发送者和接收者之间的耦合关系。

 19. 中介者模式（Mediator）
 中介者模式定义一个中介对象来封装一组对象的交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。

 20. 迭代器模式（Iterator）
 迭代器模式提供一种方法顺序访问一个聚合对象中的各个元素，而又不需要暴露该对象的内部表示。

 21. 访问者模式（Visitor）
 访问者模式表示一个作用于某对象结构中的各元素的操作。它使你可以在不改变各元素的类的前提下定义作用于这些元素的新操作。

 22. 解释器模式（Interpreter）
 解释器模式为语言创建解释器，定义了语言的文法表示，并且该解释器使用该表示来解释语言中的句子。

 这些设计模式不仅可以帮助开发者编写出结构清晰、易于维护的代码，还可以提高应用程序的可扩展性和可重用性。

 */

/*
 设计模式（Design Patterns）是一套被反复使用、多数人知晓的、经过分类编目的、代码设计经验的总结。主要分为三大类：创建型模式、结构型模式和行为型模式。

 创建型模式
 单例模式（Singleton Pattern）：确保一个类只有一个实例，并提供一个全局访问点。
 工厂模式（Factory Pattern）：定义一个创建对象的接口，但让子类决定实例化哪一个类。
 抽象工厂模式（Abstract Factory Pattern）：提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类。
 建造者模式（Builder Pattern）：将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示。
 原型模式（Prototype Pattern）：用原型实例指定创建对象的种类，并通过复制这些原型创建新的对象。
 
 结构型模式
 适配器模式（Adapter Pattern）：将一个类的接口转换成客户希望的另一个接口，使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。
 桥接模式（Bridge Pattern）：将抽象部分与它的实现部分分离，使它们都可以独立地变化。
 组合模式（Composite Pattern）：将对象组合成树形结构以表示“部分-整体”的层次结构，使得用户对单个对象和组合对象的使用具有一致性。
 装饰模式（Decorator Pattern）：动态地给一个对象添加一些额外的职责。就增加功能来说，装饰模式相比生成子类更为灵活。
 外观模式（Facade Pattern）：为子系统中的一组接口提供一个一致的界面，使得子系统更加容易使用。
 享元模式（Flyweight Pattern）：运用共享技术有效地支持大量细粒度的对象。
 代理模式（Proxy Pattern）：为其他对象提供一种代理以控制对这个对象的访问。
 
 行为型模式
 责任链模式（Chain of Responsibility Pattern）：使多个对象都有机会处理请求，从而避免请求的发送者和接收者之间的耦合。
 命令模式（Command Pattern）：将一个请求封装为一个对象，从而使您可以用不同的请求对客户进行参数化。
 解释器模式（Interpreter Pattern）：给定一种语言，定义它的文法的一种表示，并定义一个解释器，该解释器使用该表示来解释语言中的句子。
 迭代器模式（Iterator Pattern）：提供一种方法顺序访问一个聚合对象中的各个元素，而又不暴露其内部的表示。
 中介者模式（Mediator Pattern）：用一个中介对象来封装一系列的对象交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散。
 备忘录模式（Memento Pattern）：在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。
 观察者模式（Observer Pattern）：定义对象间的一种一对多的依赖关系，当一个对象的状态发生改变时，所有依赖于它的对象都得到通知并被自动更新。
 状态模式（State Pattern）：允许一个对象在其内部状态改变时改变它的行为。
 策略模式（Strategy Pattern）：定义一系列的算法，把它们一个个封装起来，并且使它们可相互替换。
 模板方法模式（Template Method Pattern）：定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。
 访问者模式（Visitor Pattern）：表示一个作用于某对象结构中的各元素的操作。它使您可以在不改变各元素的类的前提下定义作用于这些元素的新操作。

 
 */

import UIKit

class DuDesignPatternsViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: 单例模式
extension DuDesignPatternsViewController {
    // 单例模式确保一个类只有一个实例，并提供一个全局访问点。
    class Singleton {
        static let shared = Singleton()
        private init() {}
        
        func log() {
            print("Singleton")
        }
    }

    func testSingleton() {
        Singleton.shared.log()
    }
    
}

//MARK: 工厂模式
extension DuDesignPatternsViewController {
    protocol Product {
        func use()
    }
    
    class A: Product {
        func use() {
            
        }
    }
    
    class B: Product {
        func use() {
            
        }
    }
    
    class Factory {
        static func getProduct(type: String) -> Product? {
            switch type {
            case "A":
                return A()
            case "B":
                return B()
            default:
                return nil
            }
        }
    }
}

//MARK: 适配器模式
// 适配器模式将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。
extension DuDesignPatternsViewController {
    protocol Target {
        func request()
    }
    
    class Adaptee {
        func specificRequest() {
            print("Specific request")
        }
    }
    
    class Adapter: Target {
        private var adaptee: Adaptee
        init(adaptee: Adaptee) {
            self.adaptee = adaptee
        }
        
        func request() {
            adaptee.specificRequest()
        }
    }
}

//MARK: 策略模式
// 策略模式定义了一系列算法，并将每一个算法封装起来，而且使它们还可以相互替换
extension DuDesignPatternsViewController {
    protocol Strategy {
        func execute(a: Int, b: Int) -> Int
    }
    
    class AddStrategy: Strategy {
        func execute(a: Int, b: Int) -> Int {
            return a + b
        }
    }
    
    class MultiplyStrategy: Strategy {
        func execute(a: Int, b: Int) -> Int {
            return a * b
        }
    }
    
    class Context {
        private var strategy: Strategy
        init(strategy: Strategy) {
            self.strategy = strategy
        }
        
        func setStraegy(strategy: Strategy) {
            self.strategy = strategy
        }
        
        func executeStrategy(a: Int, b: Int) -> Int {
            return strategy.execute(a: a, b: b)
        }
    }
}
