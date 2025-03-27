//
//  ViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/10/25.
//

import UIKit

enum DuError: Error {
    case noWIFI(String)
}

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    var viewControllers: [String] = ["DuWebViewController", 
                                     "DuHollowViewController",
                                     "DuCompressionViewController",
                                     "DuPieChartViewController",
                                     "DuButtonViewController",
                                     "DuLocaledNumberViewController",
                                     "DuSegmentChartViewController",
                                     "DuDesignPrinciplesViewController",
                                     "DuCopyOnWriteViewController",
                                     "DuAlgorithmViewController",
                                     "DuInstrumentsViewController",
                                     "DuBluetoothViewController",
                                     "DuStructClassViewController",
                                     "DuThreadViewController",
                                     "DuClosureViewController",
                                     "DuCoreAnimationViewController",
                                     "DuURLSessionViewController",
                                     "DuLeaksViewController",
                                     "DuSwiftBaseViewController",
                                     "DuScrollViewController",
                                     "DuThemeViewController",
                                     "DuOCViewController",
                                     "DuRunLoopViewController"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        fetchData()
    }

    func setupUI() {
        view.addSubview(tableView)
    }
    
    func fetchData() {
        tableView.reloadData()
    }
    
    
    func test_throw() {
        do {
            try throwError()
        } catch {
            print(error)
        }
    }
    
    func throwError() throws {
        throw DuError.noWIFI("XIAOMI")
    }

    func weekStartAndEndDates(from date: Date) -> (startDate: Date, endDate: Date)? {
        let calendar = Calendar.current
        // 获取本周的起始日期
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start else { return nil }
        // 计算本周的结束日期（起始日期 + 6 天）
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)
        return (startDate: startOfWeek, endDate: endOfWeek ?? startOfWeek)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = "index - \(indexPath.row) - \(viewControllers[indexPath.row])"
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let className = viewControllers[indexPath.row]
        if let vc = getViewConstoller(className) {
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        } else {
            let vc = DuOCViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.randomColor
            self.present(vc, animated: true)
        }
    }

    func getViewConstoller(_ className: String) -> UIViewController? {
        if let projectName = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String {
            let fullClassName = projectName + "." + className
            guard let vcClass = NSClassFromString(fullClassName) as? UIViewController.Type else { return nil }
            return vcClass.init()
        }
        return nil
    }
}



