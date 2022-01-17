//
//  StepsView.swift
//  StepperView
//
//  Created by mohamed gamal on 17/01/2022.
//

import UIKit

@objc protocol StepsViewDelegate: AnyObject {
    @objc optional func stepBar(didSelectedItemAt index: Int)
//    func menuBarNumberOfItems() -> Int
//    func menuBar(titleForRowAt index: Int) -> String
}

class StepsView: UIView {
    @IBOutlet weak var stepsIconsCollectionView: UICollectionView!
    weak var delegate: StepsViewDelegate?

    var stepsTitles =  [String]()
    var stepTitleNumbers = [String]()
    private struct Constants {
        static let stepIconCell = "StepIconCell"
    }

    var currentStepIndex = 0 {
        didSet {
            if oldValue > self.currentStepIndex {
                (self.stepsIconsCollectionView.cellForItem(at: IndexPath(item: oldValue, section: 0)) as! StepIconCell).isPassed = false
            }
            (self.stepsIconsCollectionView.cellForItem(at: IndexPath(item: self.currentStepIndex, section: 0)) as! StepIconCell).isPassed = true
            UIView.animate(withDuration: 0.2) {

                self.layoutIfNeeded()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        self.registerCells()
    }

    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let nibName = "StepsView"
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    func registerCells() {
        let stepIconCell = UINib(nibName: Constants.stepIconCell, bundle: nil)
        self.stepsIconsCollectionView.register(stepIconCell, forCellWithReuseIdentifier: Constants.stepIconCell)
    }

}

extension StepsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stepsTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.stepIconCell, for: indexPath) as! StepIconCell
        cell.config(title: stepsTitles[indexPath.item], isFirst: indexPath.item == 0, isLast: indexPath.item == stepsTitles.count - 1, stepTitle: self.stepTitleNumbers[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / CGFloat(self.stepsTitles.count), height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.stepBar?(didSelectedItemAt: indexPath.item)
        if indexPath.item != currentStepIndex {
            if indexPath.item > currentStepIndex {
                for index in (currentStepIndex + 1)...indexPath.item {
                    self.currentStepIndex = index
                }
            } else {
                for index in (indexPath.item...currentStepIndex).reversed() {
                    self.currentStepIndex = index
                }
            }
        }
    }
}
