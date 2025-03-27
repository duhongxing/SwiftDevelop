//
//  DuScrollViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/17.
//

import UIKit

class DuCustomView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.yellow.cgColor)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 - 4
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        context.drawPath(using: .fillStroke)
        
    }
}

class DuScrollViewController: DuBaseViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let spotlightView = UIView()
    let customView = DuCustomView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        scrollView.frame = view.bounds
//        scrollView.backgroundColor = .red
//        scrollView.delegate = self
//        view.addSubview(scrollView)
//        
//        contentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        contentView.backgroundColor = .white
//        scrollView.addSubview(contentView)
//        scrollView.contentSize = contentView.bounds.size
//        
//        spotlightView.frame = CGRect(x: 0, y: -100, width: view.bounds.width, height: view.bounds.height)
//        spotlightView.backgroundColor = .gray
//        spotlightView.alpha = 0.0
//        scrollView.addSubview(spotlightView)
//        
//        scrollView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        let imageView = UIImageView(image: loadGif(name: "test"))
        imageView.center = view.center
        self.view.addSubview(imageView)
        
        self.customView.frame = CGRect(x: 80, y: 200, width: 100, height: 100)
        self.customView.backgroundColor = .clear
        self.view.addSubview(self.customView)
        
    }
    
    func loadGif(name: String) -> UIImage? {
        guard let bundleUrl = Bundle.main.url(forResource: name, withExtension: "gif") else { return nil}
        
        guard let imageData = try? Data(contentsOf: bundleUrl) else { return nil }
        
        return UIImage.animatedImage(with: getFrames(from: imageData), duration: 0.0)
        
    }
    
    
    func getFrames(from data: Data) -> [UIImage] {
        let source = CGImageSourceCreateWithData(data as CFData, nil)!
        var images = [UIImage]()
        let count = CGImageSourceGetCount(source)
        for index in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, index, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        return images
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        print("offsetY: \(offsetY)")
        
        if offsetY <= -100 {
            UIView.animate(withDuration: 0.3) {
                self.spotlightView.alpha = 1.0
            }
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.spotlightView.alpha = 0.0
            }
        }
    }
    
}

/*
 iOS 常见的 Crash 场景包括但不限于以下几种：

 内存泄漏 (Memory Leaks):

 内存泄漏会导致应用程序占用过多的内存，最终导致崩溃。
 空指针异常 (Null Pointer Exception):

 访问了一个已经释放或者为 nil 的对象。
 数组越界 (Array Out of Bounds):

 访问数组时使用了非法的索引，超出了数组的范围。
 多线程问题 (Multithreading Issues):

 不正确的线程同步可能导致数据竞争、死锁等问题。
 KVO (Key-Value Observing) 问题:

 未正确移除观察者或者重复添加观察者。
 内存警告未处理 (Unhandled Memory Warnings):

 在收到内存警告时未能及时释放内存，导致内存不足。
 递归调用导致栈溢出 (Stack Overflow Due to Recursive Calls):

 递归调用次数过多导致栈溢出。
 未捕获的异常 (Uncaught Exceptions):

 程序中抛出了未被捕获的异常。
 使用未初始化的变量 (Using Uninitialized Variables):

 访问了未初始化的变量，导致不可预知的行为。
 不兼容的库或框架 (Incompatible Libraries or Frameworks):

 使用了不兼容的第三方库或框架，导致崩溃。
 
 */


/*
 让 ViewController 瘦下来可以通过以下几种途径：

 使用 MVC 设计模式:

 将业务逻辑移到 Model 层。
 将视图相关代码移到 View 层。
 使用 MVVM 或 VIPER 设计模式:

 MVVM（Model-View-ViewModel）和 VIPER（View-Interactor-Presenter-Entity-Router）等设计模式可以更好地分离视图、业务逻辑和数据处理。
 将视图相关代码移到单独的视图类或视图控制器中:

 创建自定义视图类，将视图相关代码放入这些类中。
 使用子视图控制器:

 将复杂的视图逻辑拆分到多个子视图控制器中。
 使用委托和数据源:

 使用委托和数据源模式，将部分逻辑分离到其他类中。
 使用扩展（Extensions）:

 将辅助功能和工具函数移到扩展中。
 使用服务类或管理类:

 创建服务类或管理类，将网络请求、数据处理等逻辑移到这些类中。
 使用 Storyboard 或 XIB 文件:

 将界面布局和界面相关代码分离到 Storyboard 或 XIB 文件中。
 
 总结来说，通过合理使用设计模式和代码分离技术，可以有效地减少 ViewController 的代码量，从而使其更容易维护和测试
 
 */

/*
 当使用CoreGraphics进行图片缩放时，需要注意以下几点：

 保持图像质量：

 缩放过程中可能会导致图像质量的下降，应尽量使用高质量的插值算法，比如双线性插值或双立方插值。
 性能考虑：

 图片的缩放操作可能会消耗较多的计算资源，尤其是在处理高分辨率图片时。因此，应该在后台线程中进行这些操作，以避免阻塞UI线程。
 处理透明度：

 缩放透明图片时，应确保正确处理透明度，以避免出现不透明的背景。
 正确设置图像上下文：

 在进行图像缩放时，应创建一个合适大小的图像上下文（CGContext），并在绘制完成后释放它们。
 避免失真：

 缩放时应保持图像的宽高比，以防止图像失真。可以通过计算合适的宽度和高度来实现这一点。
 */



/*
 iOS 上播放 GIF 图片可以使用 UIImage 和 UIImageView
 FLAnimatedImage 是一个高效的 GIF 播放库，能够显著提升性能，尤其适用于大尺寸或高帧率的 GIF。
 
 优化方案
 使用高效的 GIF 库：如上所述，FLAnimatedImage 相较于直接使用 UIImage 和 UIImageView 更为高效。
 控制 GIF 大小和帧数：
 尽量使用尺寸较小、帧数较少的 GIF。
 可以通过工具（如 Photoshop）对 GIF 进行压缩和优化。
 缓存机制：
 可以使用内存缓存和磁盘缓存来减少重复加载的开销。
 FLAnimatedImage 内部已经实现了缓存机制。
 
 */

/*
 NSNotification 和 KVO（Key-Value Observing）都是 iOS 和 macOS 开发中常用的观察者模式实现，主要用于不同对象之间的通信，但它们各自有不同的使用场景和特点。

 NSNotification
 使用场景：
 跨对象通信：当一个对象需要通知多个对象某个事件发生时，NSNotification 是一个很好的选择。例如，用户登录成功后，多个视图控制器需要知道这个事件。
 全局事件广播：某些事件需要在全局范围内广播给所有感兴趣的对象，例如应用进入后台、内存警告等系统级事件。
 松耦合设计：对象之间不需要直接引用，可以通过通知中心进行通信，从而降低对象之间的耦合度。
 
 iOS 中的 NSNotification 可以在一个线程发送通知，并在另一个线程接收通知。NSNotificationCenter 是线程安全的，这意味着您可以在不同的线程之间发送和接收通知。
 注意事项
 线程安全：NSNotificationCenter 是线程安全的，可以在任意线程发送和接收通知。
 更新 UI：如果在后台线程接收到通知并需要更新 UI，请确保在主线程上执行 UI 更新代码。例如，使用 dispatch_async(dispatch_get_main_queue(), ^{ ... }); 来调度到主线程。
 移除观察者：确保在适当的时机移除观察者，尤其是当对象被释放时，以避免潜在的崩溃。

 
 
 KVO (Key-Value Observing)
 使用场景：
 属性值变化监听：当一个对象需要监听另一个对象的属性变化时，KVO 是一种高效的方法。例如，监听模型对象中某个属性的变化并在视图中做出相应更新。
 对象内部状态变化：当一个对象内部多个部分需要对某个状态变化做出反应时，可以使用 KVO。例如，视图控制器监听模型对象属性的变化以更新 UI。
 
 */

/*
 iOS 开发中，Core Graphics（又称 Quartz 2D）是一个用于处理2D绘图的框架。Core Graphics 提供了丰富的API，用于创建和绘制路径、图形、图像、阴影、渐变、颜色空间等。以下是一些常见的使用场景和注意事项：

 使用场景
 自定义绘图：

 在 drawRect: 方法中进行自定义绘图，如绘制自定义视图、图形、路径等。
 图像处理：

 加载、修改、保存图像，如裁剪、缩放、旋转、滤镜效果等。
 绘制矢量图形：

 绘制矢量图形，如线条、矩形、圆形、多边形等。
 PDF生成和显示：

 创建和绘制PDF文档内容。
 动画和图形效果：

 创建复杂的动画和图形效果，如渐变、阴影、透明度等。
 注意事项
 性能：

 尽量减少在 drawRect: 方法中的复杂绘图操作，因为每次视图重绘都会调用此方法。
 使用离屏绘图（Offscreen Rendering）提高性能，如使用 CGLayer 或 CGContext。
 坐标系统：

 iOS 的坐标系统原点在左上角，y轴向下增加。要注意坐标系的转换，特别是在处理触摸事件时。
 内存管理：

 Core Graphics 使用 Core Foundation 内存管理，需要手动管理内存。创建的对象（如 CGPath、CGImage 等）需要在合适的时机释放。
 线程安全：

 Core Graphics 的一些操作不是线程安全的，尽量在主线程中进行绘图操作，避免在多个线程中同时操作相同的图形上下文。
 Retina 屏幕支持：

 注意处理 Retina 屏幕的分辨率。使用 UIScreen.main.scale 来获取屏幕的缩放比例，确保绘图内容在 Retina 屏幕上保持高质量。
 绘图质量：

 调整抗锯齿选项（Antialiasing）、线条连接样式（Line Join）、端点样式（Line Cap）等参数，提高绘图质量。
 颜色空间：

 注意颜色空间的选择和转换，确保颜色在不同设备上的一致性。

 */

/*
 
 EXC_BAD_ACCESS 异常通常发生在访问无效内存地址时。具体原因可能包括：

 访问已被释放的对象或内存。
 试图向只读内存写入数据。
 访问空指针（NULL 或者未初始化的指针）。
 栈溢出，通常由于递归调用过深或者分配的栈空间不足。
 野指针，指针指向一个已释放或未分配的内存地址。
 这些错误在编程中比较常见，尤其是在使用手动内存管理的语言如 C 或 C++ 时。在 Objective-C 和 Swift 中，也可能因为使用不当的对象引用而引发此异常。
 */
