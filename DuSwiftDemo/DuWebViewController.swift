//
//  DuWebViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/4.
//

import UIKit
import WebKit

class DuWebViewController: DuBaseViewController, WKUIDelegate, WKNavigationDelegate {

//    lazy var webView: DuWebView = {
//        let view = DuWebView(frame: .zero)
//        view.uiDelegate = self
//        view.navigationDelegate = self
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        // Do any additional setup after loading the view.
    }

//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
//
//    }


//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//    }

   

}
