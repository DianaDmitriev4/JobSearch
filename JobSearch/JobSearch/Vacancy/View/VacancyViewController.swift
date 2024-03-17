//
//  VacancyViewController.swift
//  JobSearch
//
//  Created by User on 17.03.2024.
//

import UIKit

final class VacancyViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: VacancyViewModel
    
    // MARK: - GUI variables
    private lazy var scrollView: UIScrollView = {
    let scroll = UIScrollView()
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    private lazy var titleLabel = makeLabel(font: .boldSystemFont(ofSize: 22))
    private lazy var salaryLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var experienceLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var schedulesLabel = makeLabel(font: .systemFont(ofSize: 14))
    
    private lazy var appliedNumberView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .darkGreen
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var appliedNumberLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var appliedNumberImageView = makeImageView(name: "applied")
    
    private lazy var lookingNumberView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .darkGreen
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var lookingNumberLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var lookingNumberImageView = makeImageView(name: "looking")
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .grey3
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var companyLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var companyIconImageView = makeImageView(name: "icon")
    private lazy var mapImageView = makeImageView(name: "map")
    private lazy var addressLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var descriptionLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var taskLabel = makeLabel(font: .boldSystemFont(ofSize: 20))
    private lazy var taskDescriptionLabel = makeLabel(font: .systemFont(ofSize: 14))
    private lazy var questionLabel = makeLabel(font: .systemFont(ofSize: 14))
    
    private lazy var questionGrayLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .grey3
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var firstButton = makeButton()
    private lazy var secondButton = makeButton()
    private lazy var thirdButton = makeButton()
    private lazy var fourthButton = makeButton()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Initialization
    init(viewModel: VacancyViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setData() {
        
    }
    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = .white
        
        return label
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = .grey2
        button.layer.cornerRadius = 15
        //        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        return button
    }
    
    private func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        
        return imageView
    }
    
    private func setNavBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(views: [titleLabel,
                                 salaryLabel,
                                 experienceLabel,
                                 schedulesLabel,
                                 appliedNumberView,
                                 lookingNumberView,
                                 containerView,
                                 descriptionLabel,
                                 taskLabel,
                                 taskDescriptionLabel,
                                 questionLabel,
                                 questionGrayLabel,
                                       firstButton,
                                       secondButton,
                                       thirdButton,
                                       fourthButton])
        appliedNumberView.addSubviews(views: [appliedNumberLabel, appliedNumberImageView])
        lookingNumberView.addSubviews(views: [lookingNumberLabel, lookingNumberImageView])
        containerView.addSubviews(views: [companyLabel, companyIconImageView, mapImageView, addressLabel])
        makeConstraint()
        setNavBar()
        setData()
    }
    
    private func makeConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(16)
        }
        
        salaryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        experienceLabel.snp.makeConstraints { make in
            make.top.equalTo(salaryLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        schedulesLabel.snp.makeConstraints { make in
            make.top.equalTo(experienceLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
        }
        
        appliedNumberView.snp.makeConstraints { make in
            make.top.equalTo(schedulesLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        appliedNumberLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
        }
        
        appliedNumberImageView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
        }
        
        lookingNumberView.snp.makeConstraints { make in
            make.leading.equalTo(appliedNumberView.snp.trailing).offset(8)
            make.centerY.equalTo(appliedNumberView.snp.centerY)  //MAYBE
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        lookingNumberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
        }
        
        lookingNumberImageView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(313)
            make.height.equalTo(134)
            make.width.equalTo(328)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }
        
        companyIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(companyLabel.snp.trailing).offset(8)
            make.centerY.equalTo(companyLabel.snp.centerY)  // MAYBE
        }
        
        mapImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(companyLabel.snp.bottom).offset(8)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(mapImageView.snp.bottom).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(containerView.snp.bottom).offset(16)
        }
        
        taskLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(taskLabel.snp.bottom).offset(16)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(taskDescriptionLabel.snp.bottom).offset(32)
        }
        
        questionGrayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
        }
        
        let buttons = [firstButton, secondButton, thirdButton, fourthButton]
        for i in 0..<buttons.count {
            buttons[i].snp.makeConstraints { make in
                make.height.equalTo(33)
                if i > 0 {
                    make.top.equalTo(buttons[i - 1].snp.trailing).offset(10)
                }
            }
        }
    }
}
