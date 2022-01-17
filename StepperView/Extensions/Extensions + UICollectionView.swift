//
//  Extensions + UICollectionView.swift
//  StepperView
//
//  Created by mohamed gamal on 17/01/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.className, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath)
        return cell as! T
    }

}

extension NSObject {
    /// value that represent a className as string value
    static var className: String {
        return String(describing: self)
    }
}
