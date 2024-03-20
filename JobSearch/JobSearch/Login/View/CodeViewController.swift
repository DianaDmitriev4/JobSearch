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
    private var isAllTextFieldsFilled = false
    
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
    
    private lazy var firstTextField = makeTextFields()
    private lazy var secondTextField = makeTextFields()
    private lazy var thirdTextField = makeTextFields()
    private lazy var fourthTextField = makeTextFields()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .darkBlue
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(.grey4, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkCode), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        
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
    @objc private func checkCode() {
        if isAllTextFieldsFilled {
            dismiss(animated: true)
        }
    }
    
    private func setupUI() {
        firstTextField.becomeFirstResponder()
        navigationItem.setHidesBackButton(true, animated: false)
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
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.buttonColor.bind { buttonColor in
            DispatchQueue.main.async { [weak self] in
                self?.confirmButton.backgroundColor = buttonColor
            }
        }
        
        viewModel.textColor.bind { textColor in
            DispatchQueue.main.async { [weak self] in
                self?.confirmButton.setTitleColor(textColor, for: .normal)
            }
        }
    }
    
    private func makeTextFields() -> UITextField {
        let textField = UITextField()
        
        textField.delegate = self
        textField.backgroundColor = .grey2
        textField.layer.cornerRadius = 5
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 20)
        textField.textColor = .white
        textField.textAlignment = .center
        
        // TODO: TEXT ALIGNMENT = CENTER!!!!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 20
        
        textField.attributedPlaceholder = NSAttributedString(string: "*", attributes: [.foregroundColor: UIColor.grey3,
                                                                                       .font: UIFont.systemFont(ofSize: 20),
                                                                                       .paragraphStyle: paragraphStyle])
        
        return textField
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
        
        let textFieldsArray = [firstTextField, secondTextField, thirdTextField, fourthTextField]
        for i in 0..<textFieldsArray.count {
            textFieldsArray[i].snp.makeConstraints { make in
                make.width.equalTo(48)
                make.height.equalTo(48)
                if i > 0 {
                    make.leading.equalTo(textFieldsArray[i - 1].snp.trailing).offset(5)
                }
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension CodeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let textFieldsArray = [firstTextField, secondTextField, thirdTextField, fourthTextField]
        isAllTextFieldsFilled = viewModel.changeColorAndCheckFullness(textFields: textFieldsArray, button: confirmButton)
        
        guard let currentText = textField.text else { return }
        if currentText.count > 0 {
            switch textField {
            case firstTextField:
                secondTextField.becomeFirstResponder()
            case secondTextField:
                thirdTextField.becomeFirstResponder()
            case thirdTextField:
                fourthTextField.becomeFirstResponder()
            case fourthTextField:
                fourthTextField.resignFirstResponder()
            default:
                break
            }
        }
    }
}
