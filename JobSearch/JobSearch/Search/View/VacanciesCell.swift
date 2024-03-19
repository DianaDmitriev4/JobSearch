//
//  VacanciesCell.swift
//  JobSearch
//
//  Created by User on 16.03.2024.
//

import UIKit

final class VacanciesCell: UICollectionViewCell {
    enum State {
        case select, unselect
        
        var image: UIImage {
            switch self {
            case .select:
                return UIImage(named: "selected") ?? UIImage()
            case .unselect:
                return UIImage(named: "favorites") ?? UIImage()
            }
        }
    }
    
    // MARK: - Properties
    var viewModel: SearchViewModelProtocol?
    
    // MARK: - GUI variables
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .grey1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var lookingNumberLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .green1
        
        return label
    }()
    
    private lazy var selectedButton: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "selected"), for: .normal)
        
        return button
    }()
    
    private lazy var jobTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 16)
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
    
    private lazy var companyIconImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "icon")
        
        return view
    }()
    
    private lazy var experienceImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "experience")
        
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
        button.backgroundColor = .green1
        button.layer.cornerRadius = 10
        
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
    func set(_ dataSource: Vacancy, isSelected: Bool) {
        guard let lookingNumber = dataSource.lookingNumber,
        let town = dataSource.address.town,
        let company = dataSource.company else { return }
        
        lookingNumberLabel.text =  "Сейчас просматривает " + String(lookingNumber) + "человек"
        jobTitleLabel.text = dataSource.title
        if let salary = dataSource.salary?.short {
            salaryLabel.text = salary
        }
        cityAndCompanyLabel.text = "\(town)\n\(company)"
        experienceLabel.text = dataSource.experience?.previewText
        publishedDateLabel.text = "Опубликовано " + formatDate(from: dataSource.publishedDate ?? "")
        
        let image = isSelected ? State.select.image : State.unselect.image
        selectedButton.setImage(image, for: .normal)
    }
    
    // MARK: - Private methods
    @objc private func buttonTapped() {
        viewModel?.vacancyClosure?()
    }
    
    private func formatDate(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: date)
    }
    
    private func setupUI() {
        addSubview(container)
        container.addSubviews(views: [lookingNumberLabel,
                                      selectedButton,
                                      jobTitleLabel,
                                      salaryLabel,
                                      cityAndCompanyLabel,
                                      companyIconImageView,
                                      experienceImageView,
                                      experienceLabel,
                                      publishedDateLabel,
                                      applyJobButton])
        makeConstraint()
//        bindingViewModel()
    }
    
    private func makeConstraint() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lookingNumberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        selectedButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        jobTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(43)
            make.leading.trailing.equalToSuperview().inset(16)
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
        
        companyIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(cityAndCompanyLabel.snp.trailing).offset(5)
            make.bottom.equalTo(cityAndCompanyLabel.snp.bottom)
        }
        
        experienceImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(cityAndCompanyLabel.snp.bottom).offset(10)
        }
        
        experienceLabel.snp.makeConstraints { make in
            make.leading.equalTo(experienceImageView.snp.trailing).offset(5)
            make.top.equalTo(cityAndCompanyLabel.snp.bottom).offset(10)
        }
        
        publishedDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(experienceLabel.snp.bottom).offset(10)
        }
        
        applyJobButton.snp.makeConstraints { make in
            make.top.equalTo(publishedDateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(32)
            make.width.equalTo(296)
        }
    }
}
