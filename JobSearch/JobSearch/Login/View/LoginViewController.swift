//
//  LoginViewController.swift
//  JobSearch
//
//  Created by User on 12.03.2024.
//

import SnapKit
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    private var email: String? {
        didSet {
            viewModel.textDidChange(text: email ?? "", button: continueButton)
        }
    }
    private let inactiveButtonColor = UIColor.darkBlue
    private let inactiveTextColor = UIColor.grey4
    private var viewModel: LoginViewModelProtocol // TODO: COORDINATOR
    
    // MARK: - GUI variables
    private lazy var jobContentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .grey1
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var searchJobLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Поиск работы"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var containerTextFieldView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.cornerRadius = 5
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowRadius = 2
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.clear.cgColor
        
        textField.textColor = .white
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .grey2
        
        if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: "clear"), for: .normal)
        }
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "responses")
        let imageAttributed = NSAttributedString(attachment: imageAttachment)
        let placeholderText = "Электронная почта или телефон"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.grey4,
                                                                    .font: UIFont.systemFont(ofSize: 14),
                                                                    .baselineOffset: 6]
        
        let attributedString = NSAttributedString(string: "   " + placeholderText, attributes: placeholderAttributes)
        let fullString = NSMutableAttributedString()
        fullString.append(imageAttributed)
        fullString.append(attributedString)
        
        textField.attributedPlaceholder = fullString
        
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = spaceView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var descriptionTextFieldLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12)
        label.textColor = .red
        
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = inactiveButtonColor // TODO: WILL CHANGE
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(inactiveTextColor, for: .normal) // TODO: WILL CHANGE
        button.layer.cornerRadius = 7
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(checkEmail), for: .touchUpInside)
        return button
    }()
    
    private lazy var withPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Войти с паролем", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        return button
    }()
    
    private lazy var buttonsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var employeeContentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .grey1
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var searchEmployeeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Поиск сотрудников"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Размещение вакансий и доступ к базе резюме"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var searchEmployeeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Я ищу сотрудников", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        emailTextField.delegate = self
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
    @objc private func checkEmail() {
        let isLogin = viewModel.buttonPressed(email: email)
        if isLogin {
            present(CodeViewController(viewModel: self.viewModel), animated: true) //TODO: COORDINATOR
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
    }
    
    @objc private func hideKeyboardWhenTappedAround() {
        view.endEditing(true)
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardWhenTappedAround))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        createNavBar()
        
        view.addSubviews(views: [jobContentView, employeeContentView])
        
        // JobContentView
        jobContentView.addSubview(stackView)
        buttonsContainerView.addSubviews(views: [continueButton, withPasswordButton])
        containerTextFieldView.addSubviews(views: [emailTextField, descriptionTextFieldLabel])
        stackView.addArrangedSubviews(views: [searchJobLabel, containerTextFieldView, buttonsContainerView])
        
        // EmployeeContentView
        employeeContentView.addSubviews(views: [searchEmployeeLabel, descriptionLabel, searchEmployeeButton])
        
        makeConstraint()
        bindViewModel()
        addTapGesture()
    }
    
    private func bindViewModel() {
        viewModel.buttonColor.bind { buttonColor in
            DispatchQueue.main.async { [weak self] in
                self?.continueButton.backgroundColor = buttonColor
            }
        }
        
        viewModel.textColor.bind { textColor in
            DispatchQueue.main.async { [weak self] in
                self?.continueButton.setTitleColor(textColor, for: .normal)
            }
        }
        
        viewModel.descriptionText.bind { descriptionText in
            DispatchQueue.main.async { [weak self] in
                self?.descriptionTextFieldLabel.text = descriptionText
            }
        }
        
        viewModel.borderColor.bind { borderColor in
            DispatchQueue.main.async { [weak self] in
                self?.emailTextField.layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    private func createNavBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Вход в личный кабинет"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
    }
    
    private func makeConstraint() {
        jobContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(232)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(179)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(22)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        containerTextFieldView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionTextFieldLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(3)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(167)
            make.height.equalTo(40)
        }
        
        withPasswordButton.snp.makeConstraints { make in
            make.leading.equalTo(continueButton.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        employeeContentView.snp.makeConstraints { make in
            make.top.equalTo(jobContentView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(141)
        }
        
        searchEmployeeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(searchEmployeeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        searchEmployeeButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalTo(296)
            make.height.equalTo(32)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        email = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
    }
}
