//
//  DuMetricKitManager.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/5.
//

import Foundation
import MetricKit

class DuMetricKitManager: NSObject {
    
    static let shared = DuMetricKitManager()
    
    override init() {
        super.init()
        setupMetricKit()
    }
    
    func setupMetricKit() {
        MXMetricManager.shared.add(self)
    }
}

extension DuMetricKitManager: MXMetricManagerSubscriber {
    
    // 接收到的指标数据
    func didReceive(_ payloads: [MXMetricPayload]) {
        payloads.forEach { payload in
            print("Received metrics payload: \(payload)")
        }
    }
    
    // 接收到的诊断数据
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        payloads.forEach { payload in
            print("Received diagnostics payload: \(payload)")
        }
    }
    
}


