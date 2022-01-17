//
//  StepIconCell.swift
//  StepperView
//
//  Created by mohamed gamal on 17/01/2022.
//

import Foundation
import UIKit

class StepIconCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stepTitleLabel: UILabel!
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet var splitterViews: [UIView]!

    private let circleTransform = CAKeyframeAnimation(keyPath: "transform")
    private let circleMaskTransform = CAKeyframeAnimation(keyPath: "transform")
    private var circleShape: CAShapeLayer!
    private var circleMask: CAShapeLayer!
    var circleColor: UIColor! = UIColor(hex: "#3DB3AB") {
        didSet {
            circleShape.fillColor = circleColor.cgColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconContainerView.borderColor = UIColor(hex: "#3DB3AB")
        self.iconContainerView.borderWidth = 1.0

    }
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        self.iconContainerView.layer.cornerRadius = self.iconContainerView.frame.height / 2
        animateCircle()
    }

    var isPassed: Bool = false {
        didSet {
            self.iconContainerView.backgroundColor = isPassed ? UIColor(hex: "#EEF9F9") : UIColor(hex: "F6F6F6")
            self.titleLabel.textColor = isPassed ? UIColor(hex: "#272929"): UIColor(hex: "#272929")
            self.stepTitleLabel.textColor = isPassed ? UIColor(hex: "#272929"): UIColor(hex: "#272929")
           splitterViews.first?.backgroundColor = isPassed ? UIColor(hex: "#3DB3AB") : UIColor(hex: "#F6F6F6")
            splitterViews.last?.backgroundColor = isPassed ? UIColor(hex: "#3DB3AB"): UIColor(hex: "#F6F6F6")

            if isPassed {
                CATransaction.begin()
                circleShape?.add(circleTransform, forKey: "transform")
                circleMask?.add(circleMaskTransform, forKey: "transform")
                CATransaction.commit()
            } else {
                // remove all animations
                circleShape?.removeAllAnimations()
                circleMask?.removeAllAnimations()
            }
        }
    }

    func config(title: String, isFirst: Bool, isLast: Bool, stepTitle: String) {
        self.titleLabel.text = title
        self.stepTitleLabel.text = stepTitle
        splitterViews.first!.isHidden = isFirst
        splitterViews.last!.isHidden = isLast
        isPassed = isFirst

    }

    override func draw(_ rect: CGRect) {
        self.iconContainerView.layer.cornerRadius = self.iconContainerView.frame.height / 2
    }

    func animateCircle() {
        //===============
        // circle layer
        //===============
        circleShape = CAShapeLayer()
        circleShape.bounds = self.iconContainerView.frame
        circleShape.position = self.iconContainerView.center
        circleShape.path = UIBezierPath(ovalIn: self.iconContainerView.frame).cgPath
        circleShape.fillColor = circleColor.cgColor
        circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
        self.layer.addSublayer(circleShape)

        circleMask = CAShapeLayer()
        circleMask.bounds = self.iconContainerView.frame
        circleMask.position = self.iconContainerView.center
        circleMask.fillRule = CAShapeLayerFillRule.evenOdd
        circleShape.mask = circleMask

        let maskPath = UIBezierPath(rect: self.iconContainerView.frame)
        maskPath.addArc(withCenter: self.iconContainerView.center, radius: 0.1, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        circleMask.path = maskPath.cgPath

        //===============
        // circle layer
        //===============
        circleShape = CAShapeLayer()
        circleShape.bounds = self.iconContainerView.frame
        circleShape.position = self.iconContainerView.center
        circleShape.path = UIBezierPath(ovalIn: self.iconContainerView.frame).cgPath
        circleShape.fillColor = circleColor.cgColor
        circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
        self.layer.addSublayer(circleShape)

        circleMask = CAShapeLayer()
        circleMask.bounds = self.iconContainerView.frame
        circleMask.position = self.iconContainerView.center
        circleMask.fillRule = CAShapeLayerFillRule.evenOdd
        circleShape.mask = circleMask

        let maskPath2 = UIBezierPath(rect: self.iconContainerView.frame)
        maskPath2.addArc(withCenter: self.iconContainerView.center, radius: 0.1, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        circleMask.path = maskPath2.cgPath

        //==============================
        // circle transform animation
        //==============================
        circleTransform.duration = 0.333 // 0.0333 * 10
        circleTransform.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0)),    //  0/10
            NSValue(caTransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0)),    //  1/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)),    //  2/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)),    //  3/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.3, 1.3, 1.0)),    //  4/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.37, 1.37, 1.0)),    //  5/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.4, 1.4, 1.0)),    //  6/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.4, 1.4, 1.0))     // 10/10
        ]
        circleTransform.keyTimes = [
            0.0,    //  0/10
            0.1,    //  1/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            1.0     // 10/10
        ]

        circleMaskTransform.duration = 0.333 // 0.0333 * 10
        circleMaskTransform.values = [
            NSValue(caTransform3D: CATransform3DIdentity),                                                              //  0/10
            NSValue(caTransform3D: CATransform3DIdentity),                                                              //  2/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 1.25, self.iconContainerView.frame.height * 1.25, 1.0)),   //  3/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 2.688, self.iconContainerView.frame.height * 2.688, 1.0)),   //  4/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 3.923, self.iconContainerView.frame.height * 3.923, 1.0)),   //  5/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 4.375, self.iconContainerView.frame.height * 4.375, 1.0)),   //  6/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 4.731, self.iconContainerView.frame.height * 4.731, 1.0)),   //  7/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 5.0, self.iconContainerView.frame.height * 5.0, 1.0)),   //  9/10
            NSValue(caTransform3D: CATransform3DMakeScale(self.iconContainerView.frame.width * 5.0, self.iconContainerView.frame.height * 5.0, 1.0))    // 10/10
        ]
        circleMaskTransform.keyTimes = [
            0.0,    //  0/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            0.7,    //  7/10
            0.9,    //  9/10
            1.0     // 10/10
        ]

    }

}
