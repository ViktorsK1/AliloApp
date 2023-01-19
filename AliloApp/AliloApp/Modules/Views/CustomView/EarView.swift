//
//  CustomEarView.swift
//  AliloApp
//
//  Created by Виктор Куля on 20.08.2022.
//

import UIKit

class EarView: UIView {
    
    // MARK: - Properties
    private let shapeLayer = CAShapeLayer()
    private let isLeft: Bool
    var fillColor: UIColor = .orange {
        didSet {
            self.shapeLayer.fillColor = fillColor.cgColor
        }
    }
    private let shadowColor: UIColor = .orange 
    
    // MARK: - Init
    init(isLeft: Bool) {
        self.isLeft = isLeft
        super.init(frame: .zero)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        layer.addSublayer(shapeLayer)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
    
    // MARK: - Draw method
    override func draw(_ rect: CGRect) {

        isLeft ? createLeftEar() : createRightEar()
    }
    
    func createLeftEar() {
        let bP = UIBezierPath()
        bP.move(
            to: CGPoint(x: bounds.maxX,
                        y: bounds.maxY - 9)
        )
        bP.addQuadCurve(
            to: CGPoint(x: bounds.midX + 14,
                        y: bounds.maxY - 28),
            controlPoint: CGPoint(x: bounds.midX + 14,
                                  y: bounds.maxY - 26)
        )
        bP.addQuadCurve(
            to: CGPoint(x: bounds.midX + 3,
                        y: bounds.maxY - 23),
            controlPoint: CGPoint(x: bounds.midX + 10,
                                  y: bounds.maxY - 30)
        )
        bP.addQuadCurve(
            to: CGPoint(x: bounds.midX + 5,
                        y: bounds.maxY - 3),
            controlPoint: CGPoint(x: bounds.midX - 1,
                                  y: bounds.maxY - 9)
        )
        bP.close()
        
        shapeLayer.shadowPath = bP.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.shadowColor = shadowColor.cgColor
        shapeLayer.path = bP.cgPath
        shapeLayer.lineWidth = 3.0
    }
    
    func createRightEar() {
        let bP = UIBezierPath()
        bP.move(
            to: CGPoint(x: bounds.maxX - 30,
                        y: bounds.maxY - 9)
        )
        bP.addQuadCurve(
            to: CGPoint(
                x: bounds.midX - 14,
                y: bounds.maxY - 28),
            controlPoint: CGPoint(
                x: bounds.midX - 14,
                y: bounds.maxY - 26)
        )
        bP.addQuadCurve(
            to: CGPoint(
                x: bounds.midX - 3,
                y: bounds.maxY - 23),
            controlPoint: CGPoint(
                x: bounds.midX - 10,
                y: bounds.maxY - 30)
        )
        bP.addQuadCurve(
            to: CGPoint(
                x: bounds.midX - 5,
                y: bounds.maxY - 3),
            controlPoint: CGPoint(
                x: bounds.midX + 1,
                y: bounds.maxY - 9)
        )
        bP.close()
        
        shapeLayer.shadowPath = bP.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.shadowColor = shadowColor.cgColor
        shapeLayer.path = bP.cgPath
        shapeLayer.lineWidth = 3.0
    }
    
    func startAnimation() {
        let zeroAnimation = CABasicAnimation(keyPath: "fillColor")
        zeroAnimation.fromValue = UIColor.yellow.cgColor
        zeroAnimation.toValue = UIColor.green.cgColor
        zeroAnimation.beginTime = 0
        zeroAnimation.duration = 1.5
        
        let firstAnimation = CABasicAnimation(keyPath: "fillColor")
        firstAnimation.fromValue = UIColor.green.cgColor
        firstAnimation.toValue = UIColor.red.cgColor
        firstAnimation.beginTime = 1.5
        firstAnimation.duration = 1.5
        
        let secondAnimation = CABasicAnimation(keyPath: "fillColor")
        secondAnimation.fromValue = UIColor.red.cgColor
        secondAnimation.toValue = UIColor.blue.cgColor
        secondAnimation.beginTime = 3
        secondAnimation.duration = 1.5
        
        let thirgAnimation = CABasicAnimation(keyPath: "fillColor")
        thirgAnimation.fromValue = UIColor.blue.cgColor
        thirgAnimation.toValue = UIColor.yellow.cgColor
        thirgAnimation.beginTime = 4.5
        thirgAnimation.duration = 1.5
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        shadowAnimation.fromValue = 1
        shadowAnimation.toValue = 10
        shadowAnimation.beginTime = 0
        shadowAnimation.duration = 1.5
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 6
        animationsGroup.repeatDuration = .infinity
        animationsGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        
        animationsGroup.animations = [zeroAnimation, firstAnimation, secondAnimation, thirgAnimation, shadowAnimation]
        
        shapeLayer.add(animationsGroup, forKey: "fillColor")
    }
    
    func stopAnimation() {
        shapeLayer.removeAllAnimations()
    }
}
