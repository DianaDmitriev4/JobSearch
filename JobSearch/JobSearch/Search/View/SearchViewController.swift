//
//  SearchViewController.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: SearchViewModelProtocol
    
    // MARK: - GUI Variables
    private lazy var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        
        let width = view.frame.width
//        let height = searchBar.intrinsicContentSize.height + quickFiltersCollectionView.frame.height + vacancyCollectionView.frame.height + moreButton.frame.height + 134
//        scroll.contentSize = CGSize(width: width, height: 1000)
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        
        return scroll
    }()
    
    private let contentView: UIView = {
       let view = UIView()
        
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.searchBarStyle = .minimal
        
        if let searchImage = UIImage(named: "search") {
            searchBar.setImage(searchImage, for: .search, state: .normal)
        }
        
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Должность, ключевые слова",
                                                                             attributes: [.foregroundColor: UIColor.grey4])
        searchBar.searchTextField.backgroundColor = .grey2
        searchBar.searchTextField.layer.cornerRadius = 8
        
        return searchBar
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.backgroundColor = .grey2
        
        return button
    }()
    
    private lazy var quickFiltersCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewFlowLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    private lazy var vacancyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Вакансии для вас"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var vacancyCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewFlowLayout)
        
//        collectionView.isScrollEnabled = false

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black

        
        return collectionView
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        
        
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = false
        
        return button
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
        navigationController?.navigationBar.barTintColor = .black
        tabBarController?.tabBar.barTintColor = .black
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(views: [searchBar, settingsButton, quickFiltersCollectionView, vacancyLabel, vacancyCollectionView, moreButton])
        
        registerCells()
        makeConstraint()
        setViewModel()
    }
    
    private func registerCells() {
        quickFiltersCollectionView.register(QuickFiltersCell.self, forCellWithReuseIdentifier: "QuickFiltersCell")
        vacancyCollectionView.register(VacanciesCell.self, forCellWithReuseIdentifier: "VacanciesCell")
    }
    
    private func setViewModel() {
        viewModel.getVacancies()
        viewModel.numberOfVacancies = { [weak self] number in
            self?.moreButton.setTitle("Ещё \(number - 3) вакансии", for: .normal)
        }
        
        viewModel.reloadCollectionView = {
            self.vacancyCollectionView.reloadData()
        }
    }
    
    private func makeConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1000)
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.edges.equalToSuperview()
            make.height.equalTo(1000)
            make.width.equalTo(scrollView.snp.width)
        }
        
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(17)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalTo(searchBar.snp.trailing).offset(3)
            make.centerY.equalTo(searchBar.snp.centerY)
        }
        
        quickFiltersCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(searchBar.snp.bottom).offset(33)
            make.height.equalTo(130)
        }
        
        vacancyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(quickFiltersCollectionView.snp.bottom).offset(15)
        }
        
        vacancyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(vacancyLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(71)
        }
        
        moreButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.width.equalTo(330)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == quickFiltersCollectionView {
            return viewModel.quickFilters.count
        } else {
//            let firstThree = viewModel.vacancies.prefix(3)
//            return firstThree.count
            return viewModel.vacancies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == quickFiltersCollectionView {
            guard let quickFiltersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFiltersCell",
                                                                            for: indexPath) as? QuickFiltersCell else { return UICollectionViewCell() }
            quickFiltersCell.set(viewModel.quickFilters[indexPath.row])
            
            return quickFiltersCell
        } else {
            guard let vacanciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacanciesCell", 
                                                                         for: indexPath) as? VacanciesCell else { return UICollectionViewCell() }
            vacanciesCell.set(viewModel.vacancies[indexPath.row])
            vacanciesCell.viewModel = viewModel
            
            return vacanciesCell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == vacancyCollectionView {
            let vacancy = viewModel.vacancies[indexPath.row]
            navigationController?.pushViewController(VacancyViewController(viewModel: VacancyViewModel(vacancy)), animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == quickFiltersCollectionView  {
            return CGSize(width: 132, height: collectionView.frame.height)
        } else {
                return CGSize(width: collectionView.frame.width, height: 240) //TODO: - ВЫСЧИТАТЬ РАЗМЕР ЯЧЕЙКИ
        }
    }
}
