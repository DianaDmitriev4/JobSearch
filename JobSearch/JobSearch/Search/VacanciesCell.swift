//
//  VacanciesCell.swift
//  JobSearch
//
//  Created by User on 16.03.2024.
//

import UIKit

final class VacanciesCell: UICollectionViewCell {
    // MARK: - GUI variables
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .gray1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var lookingNumberLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .green
        
        return label
    }()
    
    private lazy var selectedImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var jobTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var cityAndCompanyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var experienceImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var experienceLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var applyJobButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Откликнуться", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 50
        
        return button
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
    func set(_ dataSource: VacanciesModel) {
        
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubview(container)
        container.addSubviews(views: [lookingNumberLabel,
                                      selectedImageView,
                                      jobTitleLabel,
                                      salaryLabel,
                                      cityAndCompanyLabel,
                                      experienceImageView,
                                      experienceLabel,
                                      publishedDateLabel,
                                      applyJobButton])
        makeConstraint()
    }
    
    private func makeConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lookingNumberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        jobTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lookingNumberLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
        }
        
        salaryLabel.snp.makeConstraints { make in
            make.top.equalTo(jobTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
        }
        
        cityAndCompanyLabel.snp.makeConstraints { make in
            if let text = salaryLabel.text,
               !text.isEmpty {
                make.top.equalTo(salaryLabel.snp.bottom).offset(10)
            } else {
                make.top.equalTo(jobTitleLabel.snp.bottom).offset(10)
            }
            make.leading.equalToSuperview().inset(16)
        }
        
        experienceImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(cityAndCompanyLabel.snp.bottom).offset(10)
        }
        
        experienceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(cityAndCompanyLabel.snp.bottom).offset(10)
        }
        
        publishedDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(experienceLabel.snp.bottom).offset(10)
        }
        
        applyJobButton.snp.makeConstraints { make in
            make.top.equalTo(publishedDateLabel)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(32)
            make.width.equalTo(296)
        }
    }
}
