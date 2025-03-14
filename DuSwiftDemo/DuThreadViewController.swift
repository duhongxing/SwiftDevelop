//
//  DuThreadViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/3.
//

import UIKit

class DuThreadViewController: DuBaseViewController {
    
    var counter = 0
    var array: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSemaphore()
    }
    
    func testSemaphore() {
        let semaphore = DispatchSemaphore(value: 1)
        DispatchQueue.global().async {
            /**
             在这个示例中，semaphore.wait() 会请求资源，如果资源可用（计数器大于零），线程将继续执行临界区代码。如果资源不可用（计数器小于或等于零），线程将被阻塞，直到有其他线程释放资源。
             */
            semaphore.wait()
            print("Task 1")
            /**
             semaphore.signal() 用于释放资源。如果有线程被阻塞在 semaphore.wait()，其中一个线程会被唤醒。如果没有线程被阻塞，计数器加一。
             */
            semaphore.signal()
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            print("Task 2")
            semaphore.signal()
        }
    }
    
    func test_queue() {
        let serialQueue = DispatchQueue(label: "com.demo.serial.queue")
        let concurrentQueue = DispatchQueue(label: "com.demo.concurrent.queue", attributes: .concurrent)
        /**
         userInteractive: 适用于需要立即响应用户交互的任务。
         userInitiated: 适用于用户主动请求的任务，这些任务需要尽快完成。
         utility: 适用于执行耗时的任务，这些任务对用户体验不那么敏感。
         background: 适用于执行后台任务，这些任务对用户体验几乎没有影响。
         */
        let globalQueue = DispatchQueue.global(qos: .userInitiated)
    }
    
    func test_syncAndAsync(_ queue: DispatchQueue) {
        
    }

    func testSafeArray() {
        let threadSafeArray = ThreadSafeArray<Int>()
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0..<1000 {
                threadSafeArray.add(i)
            }
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0..<500 {
                threadSafeArray.remove(i)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("all tasks completed")
            print("final array \(threadSafeArray.allObjects())")
        }
    }
    
    func testLockSafeArray() {
        let lockSafeArray = LockSafeArray<Int>()
        DispatchQueue.global().async {
            lockSafeArray.append(5)
            print(lockSafeArray.allObject)
        }
        
        DispatchQueue.global().async {
            lockSafeArray.append(6)
            print(lockSafeArray.allObject)
        }
        
        DispatchQueue.global().async {
            lockSafeArray.append(7)
            print(lockSafeArray.allObject)
        }
        
        DispatchQueue.global().async {
            let result = lockSafeArray.remove(at: 1)
            print(result ?? 0)
            print(lockSafeArray.allObject)
        }
    }
    
    func testConcurrent() {
        DispatchQueue.global().async {
            for _ in 0..<30 {
                self.counter += 1
                print("counter async 1: \(self.counter)")
            }
        }
        
        DispatchQueue.global().async {
            for _ in 0..<10 {
                self.counter += 1
                print("counter async 2: \(self.counter)")
            }
        }
        
        let thread1 = Thread {
            for _ in 0..<10 {
                self.array.append(1)
                print("array async 1: \(self.array)")
            }
        }
        
        let thread2 = Thread {
            for _ in 0..<10 {
                self.array.append(2)
                print("array async 2: \(self.array)")
            }
        }
        
        thread1.start()
        thread2.start()
        
    }
    
    deinit {
        print("deinit \(#filePath) \(#file) \(#function)")
    }
}

//MARK: - ThreadSafeArray

class ThreadSafeArray<T> {
    private var array: [T] = []
    //private let queue = DispatchQueue(label: "com.thread.safe.array", attributes: .concurrent)
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    func add(_ element: T) {
        semaphore.wait()
        //queue.async(flags: .barrier) {
            self.array.append(element)
        //}
        semaphore.signal()
    }
    
    func remove(_ element: T) where T: Equatable {
        semaphore.wait() // 请求资源 计数器减一
        //queue.async(flags: .barrier) {
            if let index = self.array.firstIndex(of: element) {
                self.array.remove(at: index)
            }
        //}
        semaphore.signal() // 释放资源，计数器加一
    }
    
    func allObjects() -> [T] {
        var result: [T] = []
        semaphore.wait()
        //queue.sync {
            result = self.array
        //}
        semaphore.signal()
        return result
    }
}

//MARK: - LockSafeArray

class LockSafeArray<T> {
    private var array: [T] = []
    private let lock = NSLock()
    
    func append(_ element: T) {
        lock.lock()
        array.append(element)
        lock.unlock()
    }
    
    func remove(at index: Int) -> T? {
        lock.lock()
        defer {
            lock.unlock()
        }
        guard index >= 0 && index < array.count else { return nil }
        return array.remove(at: index)
    }
    
    func get(at index: Int) -> T? {
        lock.lock()
        defer {
            lock.unlock()
        }
        guard index >= 0 && index < array.count else { return nil }
        return array[index]
    }
    
    var count: Int {
        lock.lock()
        defer {
            lock.unlock()
        }
        return array.count
    }
    
    var isEmpty: Bool {
        lock.lock()
        defer {
            lock.unlock()
        }
        return array.isEmpty
    }
    
    var allObject: [T] {
        var r: [T] = []
        r = self.array
        return r
    }
}
