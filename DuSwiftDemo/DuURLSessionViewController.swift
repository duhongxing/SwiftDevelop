//
//  DuURLSessionViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/4.
//

import UIKit
import Alamofire

class DuURLSessionViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mach
        
        var b = false
        
        b.toggle()
        b.toggle()

        print("llll".count)
        
        // Do any additional setup after loading the view.
    }
    
    
    func testAlamofire() {
        
    }
    
    func testSession() {
        if let url = URL(string: "https://www.baidu.com") {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
            }
            //
            task.resume()
        }
    }
}
