//
//  DuPieChartViewController.swift
//  DuSwiftDemo
//
//  Created by 杜红星 on 2024/11/5.
//

import UIKit
import SnapKit

class RingView: UIView {
    override func draw(_ rect: CGRect) {
        // Define the center point and radius of the circle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 10
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi

        // Create a circular path
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        // Create a shape layer to represent the ring
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor // Inside color
        shapeLayer.strokeColor = UIColor.blue.cgColor // Border color
        shapeLayer.lineWidth = 10 // Border width

        // Add the shape layer to the view's layer
        self.layer.addSublayer(shapeLayer)
    }
}


class PieChartView: UIView {
    var data: [CGFloat] = [25, 35, 40] // 饼图数据，表示各部分的比例

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 10
        var startAngle: CGFloat = -CGFloat.pi / 2
        let total = data.reduce(0, +)

        for slice in data {
            let endAngle = startAngle + 2 * .pi * (slice / total)

            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.close()

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.random().cgColor // 使用随机颜色填充

            self.layer.addSublayer(shapeLayer)

            startAngle = endAngle
        }
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat(arc4random() % 256) / 255.0,
            green: CGFloat(arc4random() % 256) / 255.0,
            blue: CGFloat(arc4random() % 256) / 255.0,
            alpha: 1.0
        )
    }
}


class SegmentedRingView: UIView {

    var segments: [(color: UIColor, value: CGFloat)] = [
        (color: .red, value: 25),
        (color: .blue, value: 35),
        (color: .green, value: 40)
    ]

    var angles: [(CGFloat, CGFloat)] = []

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "睡眠\n结构"
        self.addSubview(label)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow

        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2  - 20
        let lineWidth: CGFloat = 15
        var startAngle: CGFloat = -CGFloat.pi / 2
        let total = segments.reduce(0) { $0 + $1.value }

        for segment in segments {
            let endAngle = startAngle + 2 * .pi * (segment.value / total)

            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = segment.color.cgColor
            shapeLayer.lineWidth = lineWidth
            shapeLayer.lineCap = .butt

            self.layer.addSublayer(shapeLayer)

            startAngle = endAngle
        }
    }
}

class SlantedRingView: UIView {

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 20
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * .pi
        let lineWidth: CGFloat = 30

        // 创建路径
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        // 创建渐变图层
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        // 创建形状图层
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor

        // 创建带有渐变色的蒙版
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.lineWidth = lineWidth
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor

        // 将蒙版应用到渐变图层
        gradientLayer.mask = maskLayer

        // 添加渐变图层到视图的图层中
        self.layer.addSublayer(gradientLayer)
    }
}

class LSegmentedRingView: UIView {

    typealias RingAngles = (startAngle: CGFloat, endAngle: CGFloat)

    var segments: [(color: UIColor, value: CGFloat)] = []

    /// 外环半径
    var innerRingRadius: CGFloat = 0
    /// 内环半径
    var outerRingRadius: CGFloat = 0
    /// 圆环中心点
    var ringCenter: CGPoint = .zero
    /// 线宽
    var lineWidth: CGFloat = 15
    var dividerColor: UIColor = .white
    var dividerWidth: CGFloat = 2
    ///
    var midPoints: [CGPoint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        innerRingRadius = min(frame.width, frame.height) / 2 - lineWidth
        outerRingRadius = min(frame.width, frame.height) / 2
        ringCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
    }

    init(frame: CGRect, segments: [(color: UIColor, value: CGFloat)]) {
        super.init(frame: frame)
        innerRingRadius = min(frame.width, frame.height) / 2 - lineWidth
        outerRingRadius = min(frame.width, frame.height) / 2
        ringCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        self.segments = segments
        self.midPoints = getMidPoints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let anglesList = getRingAngleList()

        var index = 0
        anglesList.forEach { (startAngle: CGFloat, endAngle: CGFloat) in
            let segment = self.segments[index]

            // 绘制圆环的每个部分
            let path = UIBezierPath(arcCenter: self.ringCenter, radius: self.innerRingRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = self.lineWidth

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = segment.color.cgColor
            shapeLayer.lineWidth = self.lineWidth

            self.layer.addSublayer(shapeLayer)

            // 绘制分割线
            let dividerPath = UIBezierPath()
            dividerPath.move(to: ringCenter)
            dividerPath.addLine(to: CGPoint(x: self.ringCenter.x + outerRingRadius * cos(endAngle), y: ringCenter.y + outerRingRadius * sin(endAngle)))
            dividerPath.lineWidth = self.dividerWidth

            let dividerLayer = CAShapeLayer()
            dividerLayer.path = dividerPath.cgPath
            dividerLayer.strokeColor = self.dividerColor.cgColor
            dividerLayer.lineWidth = self.dividerWidth

            self.layer.addSublayer(dividerLayer)

            index += 1
        }
    }

    func getMidPoints() -> [CGPoint] {
        var points: [CGPoint] = []
        let anglesList = getRingAngleList()
        anglesList.forEach { (startAngle: CGFloat, endAngle: CGFloat) in
            let midPoint = calculateSectorMidpoint(center: ringCenter, radius: outerRingRadius, starAngle: startAngle, endAngle: endAngle)
            points.append(midPoint)
        }
        return points
    }

    func getRingAngleList() -> [RingAngles] {
        var angles: [RingAngles] = []
        let total = segments.reduce(0) { $0 + $1.value }
        // 开始角度
        var startAngle: CGFloat = -.pi / 2
        for segment in segments {
            let endAngle = startAngle + 2 * .pi * (segment.value / total)
            angles.append(RingAngles(startAngle: startAngle, endAngle: endAngle))
            startAngle = endAngle
        }
        return angles
    }

    func calculateSectorMidpoint(center: CGPoint, radius: CGFloat, starAngle: CGFloat, endAngle: CGFloat) -> CGPoint {
        let midAngle = (starAngle + endAngle) / 2
        let midX = center.x + radius * cos(midAngle)
        let midY = center.y + radius * sin(midAngle)
        return CGPoint(x: midX, y: midY)
    }
}



class DuPieChartViewController: DuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

//        let ringView = RingView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        ringView.backgroundColor = .red
//        ringView.center = view.center
//        view.addSubview(ringView)

//        let pieChart = PieChartView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        pieChart.center = view.center
//        view.addSubview(pieChart)

        var segments: [(UIColor, CGFloat)] = [(color: .red, value: 25),
                         (color: .blue, value: 35),
                         (color: .green, value: 40)]

        let segmentedRing = LSegmentedRingView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), segments: segments)
        segmentedRing.center = view.center
        view.addSubview(segmentedRing)


        let centerY = segmentedRing.ringCenter.y
        let centerX = segmentedRing.ringCenter.x

        var index = 0
        segmentedRing.midPoints.forEach { point in

            let convertPoint = segmentedRing.convert(point, to: self.view)

            var imageX: CGFloat = convertPoint.x
            var imageY: CGFloat = convertPoint.y
            var labelX: CGFloat = convertPoint.x
            var labelY: CGFloat = convertPoint.y

            var lineImage: UIImage?

            if point.x > centerX {
                lineImage = UIImage(named: "sleep_right_line")
                print("right - \(index)")
            } else {
                lineImage = UIImage(named: "sleep_left_line")
                print("left - \(index)")
                imageX -= 104
                labelX = imageX
            }

            if point.y > centerY {
                print("down - \(index)")
                imageY -= 9.5
                labelY = imageY - 20
            } else {
                labelY = imageY - 20 - 10.5
                print("up - \(index)")
            }

            let imageView = UIImageView(frame: CGRect(x: imageX, y: imageY, width: 104.5, height: 10.5))
            imageView.image = lineImage
            self.view.addSubview(imageView)

            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: 105, height: 20))
            label.text = "快速眼动"
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.view.addSubview(label)
            if point.x > centerX {
                label.textAlignment = .right
            } else {
                label.textAlignment = .left
            }

            if point.y < centerY {
                imageView.transform = CGAffineTransform(scaleX: 1, y: -1)
            }


            index += 1
        }

    }

}
