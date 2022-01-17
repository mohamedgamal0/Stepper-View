//
//  Extensions + UIView.swift
//  StepperView
//
//  Created by mohamed gamal on 17/01/2022.
//

import UIKit

// MARK: - IBInspectable Properties
extension UIView {

    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }

    @IBInspectable public var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable public var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.masksToBounds = false
        }
    }

    @IBInspectable public var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func addSubViewWithSameFrame(subView: UIView) {
        subView.frame = self.frame
        //        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)

        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.topAnchor),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func customRoundCornerscorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
