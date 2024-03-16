//
//  QuickFiltersCell.swift
//  JobSearch
//
//  Created by User on 16.03.2024.
//

import UIKit

final class QuickFiltersCell: UICollectionViewCell {
    // MARK: - GUI variables
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .gray1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
       let view = UIImageView()
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var button: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set() {
        
    }

    // MARK: - Private methods
    private func setupUI() {
        makeConstraint()
    }
    
    private func makeConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
