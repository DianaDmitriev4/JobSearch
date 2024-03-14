//
//  LoginViewController.swift
//  JobSearch
//
//  Created by User on 12.03.2024.
//

import SnapKit
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - GUI variables
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .gray1
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
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .gray2
        textField.layer.cornerRadius = 5
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "responses")
        let imageString = NSAttributedString(attachment: imageAttachment)
        let placeholderText = "Электронная почта или телефон"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray4,
                                                                    .font: UIFont.systemFont(ofSize: 14),
                                                                    .baselineOffset: 40]
        let attributedString = NSMutableAttributedString(attributedString: imageString)
        attributedString.append(NSAttributedString(string: " " + placeholderText, attributes: placeholderAttributes))

        textField.attributedPlaceholder = attributedString

        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var withPasswordButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var buttonsContainerView: UIView = {
        let view = UIView()
        
        
        
        
        return view
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        createNavBar()
        contentView.addSubview(stackView)
        view.addSubview(contentView)
        stackView.addArrangedSubviews(views: [searchJobLabel,
                                              emailTextField,
                                              buttonsContainerView])
        buttonsContainerView.addSubviews(views: [continueButton, withPasswordButton])
        makeConstraint()
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
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(232)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(179)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
