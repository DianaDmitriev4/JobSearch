//
//  SelectedViewController.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit

final class SelectedViewController: UIViewController {
    // MARK: - GUI variables
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Избранное"
        
        return label
    }()
    
    private lazy var countVacanciesLabel: UILabel = {
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .grey3
        label.text = "Избранное"
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black

        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        collectionView.register(VacanciesCell.self, forCellWithReuseIdentifier: "VacanciesCell")
    }
    
}

// MARK: - UICollectionViewDataSource
extension SelectedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

// MARK: - UICollectionViewDelegate
extension SelectedViewController: UICollectionViewDelegate {
    
}
