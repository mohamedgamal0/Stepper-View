//
//  ViewController.swift
//  StepperView
//
//  Created by mohamed gamal on 17/01/2022.
//

import UIKit

enum ReuseableCellType {
    case stepOneCell
    case stepTwoCell
    case stepThreeCell
}

class ViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stepsView: StepsView!

    // MARK: - Variables
    var indexPath = IndexPath(item: 0, section: 0)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStepsView()
        setupCollectionView()
    }
    
    // MARK: - Private Functons
    
    private func setupStepsView() {
        self.stepsView.delegate = self
        self.stepsView.stepsTitles = ["German Cheaper", "Rottweiler", "Husky"]
        self.stepsView.stepTitleNumbers = ["1", "2", "3"]
    }

    private func setupCollectionView() {
        
        collectionView.register(cellType: FirstStepCell.self)
        collectionView.register(cellType: SecondStepCell.self)
        collectionView.register(cellType: ThirdStepCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func reuseableCellType(at indexPath: IndexPath) -> ReuseableCellType {
        if indexPath.item == 0 {
            return .stepOneCell
        } else  if indexPath.item == 1 {
            return .stepTwoCell
        } else  {
            return .stepThreeCell
        }
    }
}

//MARK: - UICollectionView Data Source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.reuseableCellType(at: indexPath) {
        case .stepOneCell:
            return dequeueFirstStepCell(collectionView, cellForItemAt: indexPath)
        case .stepTwoCell:
            return dequeueSecondStepCell(collectionView, cellForItemAt: indexPath)
        case .stepThreeCell:
            return dequeueThirdStepCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func dequeueFirstStepCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FirstStepCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    private func dequeueSecondStepCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SecondStepCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    private func dequeueThirdStepCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ThirdStepCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
}

// MARK: - UICollectionView Delegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
}

// MARK: - Steps View Delegate
extension ViewController: StepsViewDelegate {
    
    func stepBar(didSelectedItemAt index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}
