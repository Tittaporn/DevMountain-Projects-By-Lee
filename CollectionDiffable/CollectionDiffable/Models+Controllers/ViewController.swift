//
//  ViewController.swift
//  CollectionDiffable
//
//  Created by Lee McCormick on 3/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    lazy var dataSource: ColorDataSource = {
        ColorDataSource(collectionView: collectionView)
    }()
    
    let mockData = [Color(color: .blue, family: .cool),
                    Color(color: .blue, family: .cool),
                    Color(color: .blue, family: .cool),
                    Color(color: .blue, family: .cool)
    ]
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        dataSource.applyItems(mockData)
    }
    
    
}

