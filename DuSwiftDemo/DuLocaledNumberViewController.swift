//
//  DuLocaledNumberViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/20.
//

import UIKit
import Foundation

protocol DuLocaledNumber {
    func getLocaledNumber(_ digitsNumber: Int) -> String
}

extension NumberFormatter {
    /// 保留小数点后几位
    static func localedDouble(num: Double, digits: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = digits
        numberFormatter.minimumFractionDigits = digits
        numberFormatter.locale = Locale.current
        numberFormatter.roundingMode = .halfUp
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "" // 去掉千位分隔符
        return numberFormatter.string(from: NSNumber(value: num)) ?? ""
    }

    static func localedInt(num: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: num))
    }
}



class DuLocaledNumberViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let number = 1234.56

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.numberStyle = .decimal // 设置数字样式为小数
        formatter.groupingSeparator = ""
        //formatter.locale = Locale(identifier: "zh_Hans_HK") // 设置地区，可以根据需要更改
        formatter.locale = Locale.current
        if let formattedNumber = formatter.string(from: NSNumber(value: number)) {
            print("Formatted number: \(formattedNumber)") // 输出: 1,234.56
        }

        let localedNumber = String(format: "%.1f", locale: Locale.current, 1234.56)
        print(localedNumber)

        // Do any additional setup after loading the view.
    }

}
