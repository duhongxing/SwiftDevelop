//
//  DuWebView.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/4.
//

import UIKit
import WebKit

class DuWebView: WKWebView {

}

extension DuWebView {
    func getCookie() -> String {
        let cookieDomain = ""
        var cookieString = ""
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if cookie.domain == cookieDomain {
                    let str = "\(cookie.name)=\(cookie.value)"
                    cookieString.append("\(str);")
                }
            }
        }
        return cookieString
    }

    func loadURLRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue(getCookie(), forHTTPHeaderField: "Cookie")
        }
    }

    func setDuCookie() {
        var cookieString = ""
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if cookie.domain == "" {
                    let str = "\(cookie.name)=\(cookie.value)"
                    cookieString.append("document.cookie='\(str);path=/;domain=devqiaoyu.tech';")
                }
            }
        }
        let cookieScript = WKUserScript(source: cookieString, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(cookieScript)

        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.userContentController = userContentController
        

    }
}
