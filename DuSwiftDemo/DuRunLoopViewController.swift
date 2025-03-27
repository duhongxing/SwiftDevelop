//
//  DuRunLoopViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/19.
//

import UIKit

class DuPermanentThread: NSObject {
    private var thread: Thread?
    private var isStopped: Bool = false
    override init() {
        super.init()
        self.thread = Thread(target: self, selector: #selector(threadEntryPoint), object: nil)
        self.thread?.start()
    }
    
    @objc func threadEntryPoint() {
        let runLoop = RunLoop.current
        let port = Port()
        runLoop.add(port, forMode: .default)
        
//        let bool = runLoop.run(mode: .default, before: .distantFuture)
//        print("\(bool)")
        
        while !isStopped {
            // keep the run loop running
            print("threadEntryPoint")
        }
        
        
    }
    
    func execute(task: @escaping () -> Void) {
        guard let thread = thread else { return }
        self.perform(#selector(runTask(_:)), on: thread, with: task, waitUntilDone: false)
    }
    
    @objc private func runTask (_ task: @escaping () -> Void) {
        task()
    }
    
    func stop() {
        self.isStopped = true
        self.thread = nil
    }
}

class DuRunLoopViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let str = "5+6-7+8-9+1"
        var tokens = str.map({String($0)})
        print(tokens)
        
        var result = 0
        
        while let token = tokens.first {
            tokens.removeFirst()
            if token == "+" {
                result += parseFactor(&tokens) ?? 0
            } else if token == "-" {
                result -= parseFactor(&tokens) ?? 0
            } else {
                result = Int(token) ?? 0
            }
        }
        
        print("result: \(result)")
        
        // Do any additional setup after loading the view.
    }
    
    func parseFactor(_ tokens: inout [String]) -> Int? {
        if let token = tokens.first, let value = Int(token) {
            tokens.removeFirst()
            return value
        }
        return nil
    }

}
