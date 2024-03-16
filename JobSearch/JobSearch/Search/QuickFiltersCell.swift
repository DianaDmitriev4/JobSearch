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
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var raiseLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .green
        label.numberOfLines = 1
        
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
    func set(_ dataSource: QuickFiltersModel) {
        iconImageView.image = dataSource.icon
        iconImageView.backgroundColor = dataSource.iconColor
        descriptionLabel.text = dataSource.description
        if let textButton = dataSource.textAction {
            raiseLabel.text = dataSource.textAction
        }
    }

    // MARK: - Private methods
    private func setupUI() {
        addSubview(container)
        container.addSubviews(views: [iconImageView, descriptionLabel, raiseLabel])
        makeConstraint()
    }
    
    private func makeConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(58)
        }
        
        raiseLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalTo(descriptionLabel).offset(5)
        }
    }
}
