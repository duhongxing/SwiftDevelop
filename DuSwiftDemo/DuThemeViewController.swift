//
//  DuThemeViewController.swift
//  DuSwiftDemo
//
//  Created by duhongxing on 2025/3/18.
//

import UIKit

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var titleTextColor: UIColor { get }
    var detailTextColor: UIColor { get }
}


class RedTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        return .red
    }
    
    var titleTextColor: UIColor {
        return .white
    }
    
    var detailTextColor: UIColor {
        return .yellow
    }
}

class BlueTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        return .blue
    }
    
    var titleTextColor: UIColor {
        return .white
    }
    
    var detailTextColor: UIColor {
        return .yellow
    }
}

class YellowTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        return .yellow
    }
    
    var titleTextColor: UIColor {
        return .white
    }
    
    var detailTextColor: UIColor {
        return .yellow
    }
}

class WhiteTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        return .white
    }
    
    var titleTextColor: UIColor {
        return .white
    }
    
    var detailTextColor: UIColor {
        return .yellow
    }
}

class BlackTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        return .black
    }
    
    var titleTextColor: UIColor {
        return .white
    }
    
    var detailTextColor: UIColor {
        return .yellow
    }
}

class GreenTheme: ThemeProtocol {
    var backgroundColor: UIColor {
        return .green
    }
    
    var titleTextColor: UIColor {
        return .white
    }
    
    var detailTextColor: UIColor {
        return .yellow
    }
}



extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    static func colorWithHex(_ hex: UInt) -> UIColor {
        let r = CGFloat((hex & 0xff0000) >> 16)
        let g = CGFloat((hex & 0x00ff00) >> 8)
        let b = CGFloat(hex & 0x0000ff)
        return rgb(r, g, b)
    }
}

enum ThemeType: CaseIterable {
    case whiteTheme
    case blackTheme
    case greenTheme
    case yellowTheme
    case redTheme
    
    var theme: ThemeProtocol? {
        get {
            switch self {
            case .whiteTheme:
                return WhiteTheme()
            case .blackTheme:
                return BlackTheme()
            case .greenTheme:
                return GreenTheme()
            case .yellowTheme:
                return YellowTheme()
            case .redTheme:
                return RedTheme()
            }
        }
    }
    
}

class ThemeManager: NSObject {
    var theme: ThemeProtocol = WhiteTheme()
    
    static let manager: ThemeManager = ThemeManager()
    
    private override init() {}
    
    func switchTheme(type: ThemeType) {
        guard let theme = type.theme else { return }
        self.theme = theme
        
        print("current: \(theme)")
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "kThemeNotificationName"), object: self.theme)
    }
    
}


class DuThemeViewController: DuBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)), name: Notification.Name(rawValue: "kThemeNotificationName"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func handleNotification(notification: Notification) {
        guard let theme = notification.object as? ThemeProtocol else { return }
        self.view.backgroundColor = theme.backgroundColor
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let themeList: [ThemeType] = ThemeType.allCases
        let count = themeList.count
        let index = Int(arc4random()) % count
        ThemeManager.manager.switchTheme(type: themeList[index])
    }
}
