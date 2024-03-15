//
//  CodeViewController.swift
//  JobSearch
//
//  Created by User on 15.03.2024.
//

import UIKit

final class CodeViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: LoginViewModelProtocol
    
    // MARK: - GUI variables
    private lazy var contentView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var sentCodeLabel: UILabel = { [weak self] in
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Отправили код на \(self?.viewModel.email ?? "")"
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var textFieldContainerView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    private lazy var firstTextField: UITextField = {
       let textField = UITextField()
        
        textField.backgroundColor = .gray2
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    private lazy var secondTextField: UITextField = {
       let textField = UITextField()
        
        textField.backgroundColor = .gray2
        
        
        return textField
    }()
    
    private lazy var thirdTextField: UITextField = {
       let textField = UITextField()
        
        textField.backgroundColor = .gray2
        
        return textField
    }()
    
    private lazy var fourthTextField: UITextField = {
       let textField = UITextField()
        
        textField.backgroundColor = .gray2
        
        return textField
    }()
    
    private lazy var confirmButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Initialization
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(contentView)
        contentView.addSubview(stackView)
        textFieldContainerView.addSubviews(views: [firstTextField,
                                                   secondTextField,
                                                   thirdTextField,
                                                   fourthTextField])
        stackView.addArrangedSubviews(views: [sentCodeLabel,
                                              descriptionLabel,
                                              textFieldContainerView,
                                              confirmButton])
        makeConstraint()
    }
    
    private func makeConstraint() {
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(162)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(225)
            make.width.equalTo(330)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let textFieldsArray: [UITextField] = [firstTextField, secondTextField, thirdTextField, fourthTextField]
        textFieldsArray.forEach { textField in
            textField.snp.makeConstraints { make in
                make.width.equalTo(48)
                make.height.equalTo(48)
                make.trailing.equalTo(textField.snp.leading)
            }
        }
    }
    
}
