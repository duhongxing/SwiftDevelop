//
//  DuSegmentChartViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/26.
//

import UIKit
import SnapKit

class DuSegmentChartViewController: DuBaseViewController {

    lazy var chartView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.spacing = 2
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.

        self.view.addSubview(chartView)

        chartView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(10)
        }

        let firstView = UIView(frame: .zero)
        firstView.backgroundColor = .purple

        let secondView = UIView(frame: .zero)
        secondView.backgroundColor = .purple

        let thirdView = UIView(frame: .zero)
        thirdView.backgroundColor = .purple

        let fourthView = UIView(frame: .zero)
        fourthView.backgroundColor = .purple

        chartView.addArrangedSubview(firstView)
        chartView.addArrangedSubview(secondView)
        chartView.addArrangedSubview(thirdView)
        chartView.addArrangedSubview(fourthView)

        




    }
    


}


