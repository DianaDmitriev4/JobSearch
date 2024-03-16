//
//  SearchViewController.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: SearchViewModelProtocol

    // MARK: - GUI Variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.searchBarStyle = .minimal
        
        if let searchImage = UIImage(named: "search") {
            searchBar.setImage(searchImage, for: .search, state: .normal)
        }
        
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Должность, ключевые слова",
                                                                             attributes: [.foregroundColor: UIColor.gray4])
        searchBar.searchTextField.backgroundColor = .gray2
        searchBar.searchTextField.layer.cornerRadius = 5
        
        return searchBar
    }()
    
    
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        
        return containerView
    }()
    
    private lazy var firstMenuView: UIView = {
        let firstMenuView = UIView()
        
        return firstMenuView
    }()
    
    private lazy var secondMenuView: UIView = {
        let firstMenuView = UIView()
        
        return firstMenuView
    }()
    
    private lazy var thirdMenuView: UIView = {
        let firstMenuView = UIView()
        
        return firstMenuView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Initialization
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubviews(views: [searchBar, settingsButton, containerView])
        containerView.addSubviews(views: [firstMenuView, secondMenuView, thirdMenuView])
        
        makeConstraint()
    }
    
    private func makeConstraint() {
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(280)
            make.top.equalToSuperview().inset(48)
            make.leading.equalToSuperview().inset(17)
        }
        
        
    }
}
