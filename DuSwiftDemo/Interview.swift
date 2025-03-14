//
//  Interview.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/14.
//

import Foundation

struct Pepole {
    var name: String
    var age: Int
    var gender: String
    
    init(name: String, age: Int, gender: String) {
        self.name = name
        self.age = age
        self.gender = gender
    }
}

extension Pepole: Equatable {
    
}


