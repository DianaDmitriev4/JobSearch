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
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    private lazy var moreButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("Ещё \(viewModel.vacancies.count - 3) вакансии", for: .normal)
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
        collectionView.register(QuickFiltersCell.self, forCellWithReuseIdentifier: "QuickFiltersCell")
        collectionView.register(VacanciesCell.self, forCellWithReuseIdentifier: "VacanciesCell")
        view.backgroundColor = .black
        view.addSubviews(views: [searchBar, settingsButton, collectionView, moreButton])
        
        makeConstraint()
        setViewModel()
    }
    
    private func setViewModel() {
        viewModel.getVacancies()
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
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.quickFilters.count
        } else {
            return viewModel.vacancies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let quickFiltersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFiltersCell", for: indexPath)
                    as? QuickFiltersCell else { return UICollectionViewCell() }
            quickFiltersCell.set(viewModel.quickFilters[indexPath.row])
            return quickFiltersCell
        } else {
            guard let vacanciesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacanciesCell", for: indexPath)
                    as? VacanciesCell else { return UICollectionViewCell() }
            
            return vacanciesCell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, scrollDirectionForSectionAt section: Int) -> UICollectionView.ScrollDirection {
        if section == 0 {
            return .horizontal
        } else {
            return .vertical
        }
    }
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0 {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8) 
    }
    
    return .zero
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           let width = indexPath.section == 0 ? firstSectionWidth 233 : 328
//           let height = indexPath.section == 0 ? 120 : 233
                if indexPath.section == 0  {
                    return CGSize(width: 132, height: 120) // Размеры для первой ячейки первой секции
                } else {
                    return CGSize(width: 50, height: 50) // Размеры для остальных ячеек
                }
            }
    



    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return section == 0 ? 8 : 16
//        }
}
