//
//  DuInstrumentsViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/2/21.
//

import UIKit

class DuInstrumentsViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        performHeavyTask()

        // Do any additional setup after loading the view.
    }

    
    func performHeavyTask() {
        DispatchQueue.global(qos: .background).async {
            let startTime = CFAbsoluteTimeGetCurrent()
            
            var sum = 0
            for i in 0..<1_000_000 {
                sum += i
            }
            
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("Time elapsed for heavy task: \(timeElapsed) seconds")
        }
    }
}
