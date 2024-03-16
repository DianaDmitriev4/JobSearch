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
        searchBar.searchTextField.layer.cornerRadius = 8
        
        return searchBar
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.backgroundColor = .gray2
        
        return button
    }()
    
//    private lazy var containerView: UIView = {
//        let containerView = UIView()
//        
//        return containerView
//    }()
//    
//    private lazy var firstImageView: UIImageView = {
//        let imageView = UIImageView()
//        
//        imageView.image = UIImage(named: "firstMenu")
//        imageView.backgroundColor = .darkBlue
//        
//        return imageView
//    }()
//    
//    private lazy var secondImageView: UIImageView = {
//        let imageView = UIImageView()
//        
//        imageView.image = UIImage(named: "secondMenu")
//        imageView.backgroundColor = .darkGreen
//        
//        return imageView
//    }()
//    
//    private lazy var firstLabel: UILabel = {
//       let label = UILabel()
//        
//        label
//        
//        return label
//    }()
//    
//    private lazy var secondLabel: UILabel = {
//       let label = UILabel()
//        
//        return label
//    }()
//    
//    private lazy var thirdLabel: UILabel = {
//       let label = UILabel()
//        
//        return label
//    }()
//    
//    private lazy var thirdImageView: UIImageView = {
//        let imageView = UIImageView()
//        
//        imageView.image = UIImage(named: "thirdMenu")
//        imageView.backgroundColor = .darkGreen
//        
//        return imageView
//    }()
//    
//    private lazy var firstMenuView: UIView = {
//        let view = UIView()
//        
//        view.backgroundColor = .gray1
//        view.layer.cornerRadius = 8
//        
//        return view
//    }()
//    
//    private lazy var secondMenuView: UIView = {
//        let view = UIView()
//        
//        return view
//    }()
//    
//    private lazy var thirdMenuView: UIView = {
//        let view = UIView()
//        
//        return view
//    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        view.addSubviews(views: [searchBar, settingsButton, collectionView])
//        containerView.addSubviews(views: [firstMenuView, secondMenuView, thirdMenuView])
        
        makeConstraint()
    }
    
    private func makeConstraint() {
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.top.equalToSuperview().inset(48)
            make.leading.equalToSuperview().inset(17)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalTo(searchBar.snp.trailing).offset(3)
            make.top.equalToSuperview().inset(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
//        containerView.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(9)
//            make.top.equalTo(searchBar.snp.bottom).offset(33)
//            make.height.equalTo(120)
//            make.width.equalTo(412)
//        }
        
        
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    
}
