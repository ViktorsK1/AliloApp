//
//  CustomView.swift
//  AliloApp
//
//  Created by Виктор Куля on 16.08.2022.
//

import UIKit

class RabbitView: UIView {
    
    // MARK: - Properties
    private var rabbitColor = UIColor.red {
        didSet {
            self.setNeedsDisplay()
        }
    }
    private let earLeftView: EarView = {
        let customView = EarView(isLeft: true)
        customView.backgroundColor = .clear
        return customView
    }()
    private let earRightView: EarView = {
        let customView = EarView(isLeft: false)
        customView.backgroundColor = .clear
        return customView
    }()
    
    private var earsViews: [EarView] {
        [earLeftView, earRightView]
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    private func initialSetup() {
        setupUI()
        makeConstraints()
    }
    
    private func setupUI() {
        [earLeftView, earRightView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            earLeftView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20),
            earLeftView.topAnchor.constraint(equalTo: self.topAnchor),
            earLeftView.widthAnchor.constraint(equalToConstant: 30),
            earLeftView.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            earRightView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +20),
            earRightView.topAnchor.constraint(equalTo: self.topAnchor),
            earRightView.widthAnchor.constraint(equalToConstant: 30),
            earRightView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Draw method
    override func draw(_ rect: CGRect) {
        rabbitCustomView()
    }

    func rabbitCustomView() {
        let bP = UIBezierPath()
        
        let xDiff1: CGFloat = bounds.width * 0.22
        let xDiff2: CGFloat = bounds.width * 0.5
        let xDiff3: CGFloat = bounds.width * 0.18
        let xDiff4: CGFloat = bounds.width * 0.17
        let xDiff5: CGFloat = bounds.width * 0.03
        let xDiff6: CGFloat = bounds.width * 0.25
        
        let yDiff1: CGFloat = bounds.width * 0.5
        let yDiff2: CGFloat = bounds.width * 0.2
        let yDiff3: CGFloat = bounds.width * 0.98
        let yDiff4: CGFloat = bounds.width * 0.7
        let yDiff5: CGFloat = bounds.width * 1.2
        let yDiff6: CGFloat = bounds.width * 1.1
        let yDiff7: CGFloat = bounds.width * 1.4
        
        
        bP.move(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        bP.addQuadCurve(to: CGPoint(x: bounds.midX + xDiff1, y: bounds.maxY - yDiff1),
                        controlPoint: CGPoint(x: bounds.midX + xDiff2, y: bounds.maxY - yDiff2))
        bP.addQuadCurve(to: CGPoint(x: bounds.midX + xDiff3, y: bounds.maxY - yDiff3),
                        controlPoint: CGPoint(x: bounds.midX + xDiff5, y: bounds.maxY - yDiff4))
        
        bP.addQuadCurve(to: CGPoint(x: bounds.midX + xDiff4, y: bounds.maxY - yDiff5),
                        controlPoint: CGPoint(x: bounds.midX + xDiff6, y: bounds.maxY - yDiff6))
        bP.addQuadCurve(to: CGPoint(x: bounds.midX - xDiff4, y: bounds.maxY - yDiff5),
                        controlPoint: CGPoint(x: bounds.midX, y: bounds.maxY - yDiff7))
        bP.addQuadCurve(to: CGPoint(x: bounds.midX - xDiff3, y: bounds.maxY - yDiff3),
                        controlPoint: CGPoint(x: bounds.midX - xDiff6, y: bounds.maxY - yDiff6))
        
        bP.addQuadCurve(to: CGPoint(x: bounds.midX - xDiff1, y: bounds.maxY - yDiff1),
                        controlPoint: CGPoint(x: bounds.midX - xDiff5, y: bounds.maxY - yDiff4))
        bP.addQuadCurve(to: CGPoint(x: bounds.midX - xDiff2, y: bounds.maxY),
                        controlPoint: CGPoint(x: bounds.midX - xDiff2, y: bounds.maxY - yDiff2))
        bP.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.systemPink.cgColor
        shapeLayer.path = bP.cgPath
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func updateEarsColor(_ color: UIColor) {
        earLeftView.fillColor = color
        earRightView.fillColor = color
    }
    
    func startEarsAnimation() {
        earsViews.forEach {
            $0.startAnimation()
        }
    }
    
    func stopEarsAnimation() {
        earsViews.forEach {
            $0.stopAnimation()
        }
    }
}
