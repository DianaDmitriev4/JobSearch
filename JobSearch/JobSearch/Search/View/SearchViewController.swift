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
        registerCells()
        view.backgroundColor = .black
//        view.addSubview(scrollView)
//        view.addSubview(contentView)
        view.addSubviews(views: [searchBar, settingsButton, quickFiltersCollectionView, vacancyLabel, vacancyCollectionView, moreButton])
        
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
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//        
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
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
            make.bottom.equalTo(moreButton.snp.top).offset(23)
        }
        
        moreButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.width.equalTo(330)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
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
            let firstThree = viewModel.vacancies.prefix(3)
            return firstThree.count
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, scrollDirectionForSectionAt section: Int) -> UICollectionView.ScrollDirection {
        switch collectionView {
        case quickFiltersCollectionView:
            return .horizontal
        case vacancyCollectionView:
            return .vertical
        default: break
        }
        return .vertical
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == quickFiltersCollectionView  {
            return CGSize(width: 132, height: collectionView.frame.height)
        } else {
            if (viewModel.vacancies[indexPath.row].salary?.short) != nil {
                return CGSize(width: collectionView.frame.width, height: 300)
            } else {
                return CGSize(width: collectionView.frame.width, height: 286) //TODO: - ВЫСЧИТАТЬ РАЗМЕР ЯЧЕЙКИ
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == quickFiltersCollectionView  {
            return UIEdgeInsets(top: 0, left: 0, bottom: 13, right: 0)
        } else {
            return UIEdgeInsets(top: 13, left: 0, bottom: 5, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        if collectionView == quickFiltersCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        }
    }
}
