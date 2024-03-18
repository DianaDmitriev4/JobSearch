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
    
    private lazy var vacanciesCollectionView: UICollectionView = {
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
        view.addSubviews(views: [titleLabel, countVacanciesLabel, vacanciesCollectionView])
        vacanciesCollectionView.register(VacanciesCell.self, forCellWithReuseIdentifier: "VacanciesCell")
    }
    
    private func makeConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        countVacanciesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        vacanciesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(countVacanciesLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
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
