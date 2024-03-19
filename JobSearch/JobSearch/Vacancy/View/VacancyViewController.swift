//
//  VacancyViewController.swift
//  JobSearch
//
//  Created by User on 17.03.2024.
//

import CoreLocation
import MapKit
import UIKit

final class VacancyViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: VacancyViewModel
    
    // MARK: - GUI variables
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        
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
        
        view.backgroundColor = .grey1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var companyLabel = makeLabel(font: .boldSystemFont(ofSize: 14))
    private lazy var companyIconImageView = makeImageView(name: "icon")
//    private lazy var mapImageView = makeImageView(name: "map")
    private lazy var map: MKMapView = {
       let map = MKMapView()
    
        return map
    }()
    
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
    
    private lazy var firstButton = makeButton(color: .grey2, titleSize: 14)
    private lazy var secondButton = makeButton(color: .grey2, titleSize: 14)
    private lazy var thirdButton = makeButton(color: .grey2, titleSize: 14)
    private lazy var fourthButton = makeButton(color: .grey2, titleSize: 14)
    private lazy var applyButton = makeButton(color: .systemGreen, titleSize: 16)
    
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
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addOrRemoveFromFavorites() {
        
    }
    
    private func decodeAndSetAddress() {
        if let town = viewModel.address.town,
           let street = viewModel.address.street,
           let house = viewModel.address.house {
            let address = town + ", " + street + ", " + house
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { placemarks, error in
                if let placemark = placemarks?.first,
                   let coordinate = placemark.location?.coordinate {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    
                    self.map.addAnnotation(annotation)
                    self.map.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
                } else {
                    debugPrint("Geocoding error: \(String(describing: error))")
                }
            }
        }
    }
    
    private func setData() {
        titleLabel.text = viewModel.title
        salaryLabel.text = viewModel.salary?.full
        experienceLabel.text = "Требуемый опыт: " + (viewModel.experience?.text ?? "")
        
        var schedulesArray = viewModel.schedules
        schedulesArray[0] = schedulesArray[0].capitalized
        let stringForSchedules = schedulesArray.map { $0 }.joined(separator: ", ")
        schedulesLabel.text = stringForSchedules
        
        if let appliedNumber = viewModel.appliedNumber {
            switch appliedNumber {
            case 1:
                appliedNumberLabel.text = String(appliedNumber) + " человек откликнулcя"
            case 2...4:
                appliedNumberLabel.text = String(appliedNumber) + " человека откликнулось"
            default:
                appliedNumberLabel.text = String(appliedNumber) + " человек откликнулось"
            }
        }
        
        if let lookingNumber = viewModel.lookingNumber {
            switch lookingNumber {
            case 1:
                lookingNumberLabel.text = String(lookingNumber) + " человек откликнулcя"
            case 2...4:
                lookingNumberLabel.text = String(lookingNumber) + " человека откликнулось"
            default:
                lookingNumberLabel.text = String(lookingNumber) + " человек откликнулось"
            }
        }
        
        companyLabel.text = viewModel.company
        if let town = viewModel.address.town,
           let street = viewModel.address.street,
           let house = viewModel.address.house {
            addressLabel.text = "\(town), \(street), \(house)"
        }
        
        descriptionLabel.text = viewModel.description
        taskLabel.text = "Ваши задачи"
        
        taskDescriptionLabel.text = viewModel.responsibilities // NEEDS TO CHANGE
        
        questionLabel.text = "Задайте вопрос работодателю"
        questionGrayLabel.text = "Он получит его с откликом на вакансию"
        
        let buttonsQuestion = [firstButton, secondButton, thirdButton, fourthButton]
        if let questions = viewModel.questions {
            buttonsQuestion.enumerated().forEach { index, button in
                if index < questions.count {
                    button.setTitle(questions[index], for: .normal)
                } else {
                    button.isHidden = true
                }
            }
        }
        
        applyButton.setTitle("Откликнуться", for: .normal)
    }
    
    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    private func makeButton(color: UIColor, titleSize: CGFloat) -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = color
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: titleSize)
        button.configuration = .borderless()
        
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
        
        let firstIcon = UIBarButtonItem(image: UIImage(named: "eye"), style: .plain, target: nil, action: nil)
        let secondIcon = UIBarButtonItem(image: UIImage(named: "icon2"), style: .plain, target: nil, action: nil)
        let thirdIcon = UIBarButtonItem(image: UIImage(named: "selected"), style: .plain, target: self, action: #selector(addOrRemoveFromFavorites))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [firstIcon, flexibleSpace, secondIcon, flexibleSpace, thirdIcon].reversed()
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
                                        fourthButton,
                                        applyButton])
        appliedNumberView.addSubviews(views: [appliedNumberLabel, appliedNumberImageView])
        lookingNumberView.addSubviews(views: [lookingNumberLabel, lookingNumberImageView])
        containerView.addSubviews(views: [companyLabel, companyIconImageView, map, addressLabel])
        makeConstraint()
        setNavBar()
        setData()
        decodeAndSetAddress()
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
            make.top.equalToSuperview().inset(30)
            make.leading.trailing.equalToSuperview().inset(16)
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
            make.trailing.equalTo(appliedNumberImageView.snp.leading).offset(8)
        }
        
        appliedNumberImageView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
        }
        
        lookingNumberView.snp.makeConstraints { make in
            make.leading.equalTo(appliedNumberView.snp.trailing).offset(8)
            make.centerY.equalTo(appliedNumberView.snp.centerY)
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        lookingNumberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(lookingNumberImageView.snp.leading).offset(8)
        }
        
        lookingNumberImageView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(lookingNumberView.snp.bottom).offset(24)
            make.height.equalTo(134)
            make.width.equalTo(328)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(12)
        }
        
        companyIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(companyLabel.snp.trailing).offset(8)
            make.centerY.equalTo(companyLabel.snp.centerY)
        }
        
        map.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(companyLabel.snp.bottom).offset(8)
            make.height.equalTo(58)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(map.snp.bottom).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(containerView.snp.bottom).offset(16)
        }
        
        taskLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalTo(taskLabel.snp.bottom).offset(16)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(taskDescriptionLabel.snp.bottom).offset(32)
        }
        
        questionGrayLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(questionLabel.snp.bottom).offset(16)
        }
        
        firstButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(questionGrayLabel.snp.bottom).offset(16)
        }
        
        secondButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(firstButton.snp.bottom).offset(8)
        }
        
        thirdButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(secondButton.snp.bottom).offset(8)
        }
        
        fourthButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(thirdButton.snp.bottom).offset(8)
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.equalTo(fourthButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(330)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
